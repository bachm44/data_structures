#include <stdbool.h>
#include "methods_interface.h"
#include "single_linked_list.h"

#ifndef BINARY_TREE_DEF
#define BINARY_TREE_DEF

struct binary_tree {
	struct binary_tree_node *root;
	struct methods_interface *interface;
	size_t size;
	int el_cnt;
};

struct binary_tree_node {
	void *data;
	struct binary_tree_node *left;
	struct binary_tree_node *right;
};

struct binary_tree *binary_tree_init(struct methods_interface *interface,
				     size_t size);

bool binary_tree_add(struct binary_tree **tree, void *data);

void *binary_tree_get_by_value(struct binary_tree *tree, int index);

void binary_tree_free(struct binary_tree *tree);

void binary_tree_clear(struct binary_tree **tree);

void binary_tree_dfs_inorder(struct binary_tree *tree,
			     struct single_linked_list **result);

void binary_tree_dfs_preorder(struct binary_tree *tree,
			      struct single_linked_list **result);

void binary_tree_dfs_postorder(struct binary_tree *tree,
			       struct single_linked_list **result);

#endif