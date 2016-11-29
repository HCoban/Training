def check_binary_search_tree_(root):
  return is_BST(root)


def is_BST(node, min=None, max=None):
  if node is None:
    return True
  elif (min != None and node.data <= min) or (max != None and node.data >= max):
        return False
  else:
        return is_BST(node.left, min, node.data) and is_BST(node.right, node.data, max)
