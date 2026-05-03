#!/usr/bin/env python3
"""
kdl_merge.py - Fusiona un archivo KDL origen en un archivo KDL destino.

Estrategia:
  - Nodos SINGLETON (binds, layout, cursor, etc.):
      Si ya existe en destino → fusiona hijos (origen sobrescribe destino clave a clave)
      Si no existe → añade el nodo entero
  - Nodos REPETIBLES (window-rule, layer-rule, output, etc.):
      Se añaden siempre al final

La clave de fusión de un nodo hijo es solo su NOMBRE, para que nodos como
'gaps 4' sobrescriban 'gaps 3' aunque los argumentos difieran.
Para keybinds dentro de binds{} se usa nombre+props (sin args) porque el
nombre ya es único por keybind (ej: 'Mod+V').

Uso: python3 kdl_merge.py <destino.kdl> <origen.kdl>
     El resultado sobreescribe destino.kdl.
"""

import sys
import kdl

SINGLETON_NODES = {
    "binds", "layout", "cursor", "recent-windows", "input",
    "environment", "animations", "gestures", "hotkey-overlay",
}

# Nodos cuya clave de fusión es solo el nombre (no los argumentos)
# para que 'gaps 4' sobrescriba 'gaps 3'
NAME_ONLY_KEY_PARENTS = {
    "layout", "cursor", "recent-windows", "input", "environment",
    # Sub-bloques de layout donde los hijos son siempre clave=nombre
    "border", "focus-ring", "shadow", "struts", "tab-indicator", "insert-hint",
    "highlight", "previews",
}

PRINT_CFG = kdl.PrintConfig(indent="    ")


def fix_numbers(doc):
    """
    kdl-py parsea todos los números como float.
    Niri requiere enteros en muchos campos.
    Convertimos x.0 → int(x) para todos los valores numéricos.
    """
    def fix_value(v):
        if isinstance(v, float) and v == int(v):
            return int(v)
        return v

    def fix_node(node):
        node.args = [fix_value(a) for a in node.args]
        node.props = {k: fix_value(v) for k, v in node.props.items()}
        for child in node.nodes:
            fix_node(child)

    for node in doc.nodes:
        fix_node(node)


def node_key(node, parent_name=None):
    """
    Clave de identificación para fusión.
    - En nodos hijo de layout/cursor/etc: solo el nombre
    - En nodos hijo de binds: nombre (el keybind es el nombre, ej 'Mod+V')
    """
    if parent_name in NAME_ONLY_KEY_PARENTS or parent_name == "binds":
        return node.name
    # Por defecto: nombre + args + props
    args = tuple(str(a) for a in node.args)
    props = tuple(sorted((k, str(v)) for k, v in node.props.items()))
    return (node.name, args, props)


def merge_children(dest_node, src_node):
    """
    Fusiona los hijos de src_node en dest_node.
    - Si un hijo tiene sub-hijos (es un bloque, ej: border{}, focus-ring{}):
        se fusiona recursivamente, preservando nodos flag como 'off'
    - Si es un nodo hoja (valor simple, ej: gaps, width):
        src sobreescribe dest si tienen el mismo nombre
    - Nodos nuevos se añaden al final
    """
    dest_index = {}
    for i, child in enumerate(dest_node.nodes):
        key = node_key(child, dest_node.name)
        dest_index[key] = i

    for src_child in src_node.nodes:
        key = node_key(src_child, dest_node.name)
        if key in dest_index:
            dest_child = dest_node.nodes[dest_index[key]]
            # Si ambos tienen sub-hijos, fusionar recursivamente
            if dest_child.nodes and src_child.nodes:
                merge_children(dest_child, src_child)
            else:
                # Nodo hoja: src sobreescribe dest
                dest_node.nodes[dest_index[key]] = src_child
        else:
            dest_node.nodes.append(src_child)
            dest_index[key] = len(dest_node.nodes) - 1


def merge_docs(dest_doc, src_doc):
    """Fusiona src_doc en dest_doc."""
    dest_singletons = {}
    for i, node in enumerate(dest_doc.nodes):
        if node.name in SINGLETON_NODES:
            dest_singletons[node.name] = i

    for src_node in src_doc.nodes:
        if src_node.name in SINGLETON_NODES:
            if src_node.name in dest_singletons:
                merge_children(dest_doc.nodes[dest_singletons[src_node.name]], src_node)
            else:
                dest_doc.nodes.append(src_node)
                dest_singletons[src_node.name] = len(dest_doc.nodes) - 1
        else:
            dest_doc.nodes.append(src_node)


def main():
    if len(sys.argv) != 3:
        print(f"Uso: {sys.argv[0]} <destino.kdl> <origen.kdl>", file=sys.stderr)
        sys.exit(1)

    dest_path, src_path = sys.argv[1], sys.argv[2]

    dest_doc = kdl.parse(open(dest_path).read())
    src_doc = kdl.parse(open(src_path).read())

    merge_docs(dest_doc, src_doc)
    fix_numbers(dest_doc)

    with open(dest_path, "w") as f:
        f.write(dest_doc.print(PRINT_CFG))


if __name__ == "__main__":
    main()
