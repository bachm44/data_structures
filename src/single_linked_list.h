#include <stdio.h>
#include <stdbool.h>
#include "methods_interface.h"

struct single_linked_list {
	struct node *root;
	struct methods_interface *interface;
};

struct node {
	void *data;
	struct node *next;
};

struct single_linked_list *init(struct methods_interface *interface);

void add(struct single_linked_list **list, void *data);

void add_many(struct single_linked_list **list, int number_of_args, ...);

void add_at(struct single_linked_list **list, int index, void *data);

void *get_at(struct single_linked_list *list, int index);

void merge_sort(struct single_linked_list **list);

bool delete_by_content(struct single_linked_list **list, void *data);

bool delete_by_index(struct single_linked_list **list, int index);

void free_list(struct single_linked_list *list);

void clear_list(struct single_linked_list **list);

void print_list(struct node *head);