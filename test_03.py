def remove_duplicates(l: list[int]) -> list[int]:
    # sets can't contain duplicates. So make a set of the list
    # and return that set as a list. Done.
    return list(set(l))


def remove_duplicates_with_local_array(l: list[int]):
    # Create a new list to store the unique elements
    unique_list: list[int] = []

    # Iterate through the sorted list
    for val in l:
        # If the unique list is empty or the current number is not equal to the last value of `unique_list`
        if len(unique_list) == 0 or val != unique_list[-1]:
            # Append the current number to the unique list
            unique_list.append(val)

    return unique_list


def remove_duplicates_in_place(sorted_list):
    # Initialize the index of the next unique element
    write_index = 1

    # Iterate through the list starting from the second element
    for i in range(1, len(sorted_list)):
        if sorted_list[i] != sorted_list[i - 1]:
            # Update the position of the next unique element
            sorted_list[write_index] = sorted_list[i]
            write_index += 1

    num_of_elements_beyond_sorted_section = len(sorted_list) - write_index

    # remove values beyond sorted section
    for i in range(num_of_elements_beyond_sorted_section):
        sorted_list.pop(-1)

    return sorted_list


def main() -> None:
    print(remove_duplicates([1, 2, 2, 3, 4, 4, 4, 5]))
    print(remove_duplicates_with_local_array([1, 2, 2, 3, 4, 4, 4, 5]))
    print(remove_duplicates_in_place([1, 2, 2, 3, 4, 4, 4, 5]))


if __name__ == '__main__':
    main()

# removeDuplicates([1,1,2]) => [1,2]
