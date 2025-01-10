package test

import "core:fmt"
import "core:slice"
import "core:time"
print :: fmt.println

main :: proc() {

	// APPROACH 01: -------------------------------------------------------------------
	start: time.Time = time.now()

	// code goes here
	val_01 := removeDuplicates([]int{1, 2, 2, 3, 4, 4, 4, 5})

	elapsed: time.Duration = time.since(start)
	print("Odin took:", elapsed)

	print(val_01)

	// APPROACH 02: -------------------------------------------------------------------

	arr_01 := [dynamic]int{1, 2, 2, 3, 4, 4, 4, 5}
	defer delete(arr_01)

	start = time.now()

	remove_duplicates_in_place(&arr_01)

	elapsed = time.since(start)
	print("Odin took:", elapsed)

	print(arr_01)


	free_all(context.temp_allocator)
}

removeDuplicates :: proc(l: []int) -> []int {
	local_set := make(map[int]struct {})
	defer delete(local_set)

	for val in l {
		if val not_in local_set {
			local_set[val] = {}
		}
	}

	local_array := make([dynamic]int, context.temp_allocator)
	for val in local_set {
		append(&local_array, val)
	}

	slice.sort(local_array[:])
	return local_array[:]
}


remove_duplicates_in_place :: proc(sorted_list: ^[dynamic]int) {
	// Initialize the index of the next unique element
	write_index := 1

	// Iterate through the list starting from the second element
	for i in 1 ..< len(sorted_list) {
		if sorted_list[i] != sorted_list[i - 1] {
			// Update the position of the next unique element
			sorted_list[write_index] = sorted_list[i]
			write_index += 1
		}
	}

	num_of_elements_beyond_sorted_section := len(sorted_list) - write_index

	// remove values beyond sorted section
	for _ in 0 ..< num_of_elements_beyond_sorted_section {
		pop(sorted_list)
	}
}


/*
Part of the reason I like Odin is that is shows the cost of an approach WAY MORE than Python does. 
For example, it may seem that the python solution
```python
def remove_duplicates(l: list[int]) -> list[int]:
    # sets can't contain duplicates. So make a set of the list
    # and return that set as a list. Done.
    return list(set(l))
```
is good because it's so straightforward to understand. However, implementing the same solution in Odin 
reveals what actually has to happen for that solution to work. Namely, allocating memory for a set and 
a dynamic array (which is not *bad*, but takes time to do) (see `removeDuplicates ` proc in Odin ). 
A far more efficient solution is to modify the array in place and do no heap allocations at all. 
(see `remove_duplicates_in_place ` proc in Odin). The results are clear:  32.78µs versus 1.889µs. 
Sheeeeesh! :smile:
*/
