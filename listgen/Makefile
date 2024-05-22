NAME = listgen

SOURCES = src/main.c \
		  src/ft_atoi.c \
		  src/ft_putchar_fd.c \
		  src/ft_putendl_fd.c \
		  src/ft_putnbr_fd.c \
		  src/ft_putstr_fd.c \
		  src/ft_range.c
OBJECTS = $(SOURCES:.c=.o)

CC = cc

CFLAGS = -Wall -Wextra -Werror -Iinclude -O3

all: $(NAME)

$(NAME): $(OBJECTS)
	$(CC) -O3 $(OBJECTS) -o $(NAME)

clean:
	rm -f $(OBJECTS)

fclean: clean
	rm -f $(NAME)

re: fclean all
