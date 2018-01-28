#include <stdio.h>

int main()
{
	int arr[10];

	int count = sizeof(arr) / sizeof(arr[0]);
	for (int i = 0 ; i < count ; ++i)
		scanf("%d", &arr[i]);

	int sum = prime_sum(arr, count);
	printf("sum: %d\n", sum);
}

int is_prime(int value)
{
	if (value <= 1)
		return 0;
	for (int i = 2 ; i < value ; ++i)
		if (value % i == 0)
			return 0;

	return 1;
}

int prime_sum(int arr[], int count)
{
	int sum = 0;
	for (int i = 0 ; i < count ; ++i)
		sum += is_prime(arr[i]) ? arr[i] : 0;

	return sum;
}

