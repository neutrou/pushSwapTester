/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_range.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: athill <marvin@42.fr>                      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/12/01 10:12:07 by athill            #+#    #+#             */
/*   Updated: 2023/12/01 11:18:48 by athill           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>

int	*ft_range(int min, int max)
{
	int				*array;
	unsigned int	size;
	unsigned int	i;

	if (min >= max)
		return (0);
	size = (unsigned int)max - (unsigned int)min;
	array = malloc(size * sizeof(int));
	if (array == 0)
		return (0);
	i = 0;
	while (i < size)
	{
		array[i] = min + i;
		i++;
	}
	return (array);
}
