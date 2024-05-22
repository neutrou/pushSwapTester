/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: athill <marvin@42.fr>                      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/03/11 11:11:25 by athill            #+#    #+#             */
/*   Updated: 2024/03/12 11:27:33 by athill           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <time.h>
#include "libft.h"

static void shuffle(int *array, int n)
{
	int	i;
	int	j;
	int	tmp;

	i = n - 1;
	while (i)
	{
		j = rand() % (i + 1);
		tmp = array[j];
		array[j] = array[i];
		array[i] = tmp;
		i--;
	}
}

static void	put_nbr(int	n)
{
	ft_putnbr_fd(n, 1);
	ft_putstr_fd(" ", 1);
}

int	main(int argc, char **argv)
{
	int	count;
	int	mode;
	int	i;
	int	*range;

	if (argc < 3)
	{
		ft_putendl_fd("Generates a list of numbers for usage as arguments of push_swap", 1);
		ft_putendl_fd("Usage:", 1);
		ft_putendl_fd("./listgen [COUNT] [MODE] (SEED)", 1);
		ft_putendl_fd("Modes:", 1);
		ft_putendl_fd("0	sorted list", 1);
		ft_putendl_fd("1	reverse sorted list", 1);
		ft_putendl_fd("2	random list, will use time as seed if not given", 1);
		return (1);
	}
	count = ft_atoi(argv[1]);
	if (count <= 0)
		return (0);
	mode = ft_atoi(argv[2]);
	i = 0;
	if (mode == 0)
		while (i < count)
			put_nbr(i++);
	else if (mode == 1)
		while (i < count)
			put_nbr(count - ++i);
	else
	{
		if (argc > 3)
			srand(ft_atoi(argv[3]));
		else
			srand(time(NULL));
		range = ft_range(0, count);
		shuffle(range, count);
		while (i < count)
			put_nbr(range[i++]);
		free(range);
	}
	return (0);
}
