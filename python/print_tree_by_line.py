import sys

class Tree:
    def __init__(self, pay, left=None, right=None):
        self.pay = pay
        self.left = left
        self.right = right

    def print_by_line(self):
        final = []
        q = [(self, 0)]
        prev_level = -1
        while len(q) > 0:
            cur, level = q.pop(0) # Take first off of queue
            if cur is not None:
                if level > prev_level:
                    print
                    prev_level = level
                sys.stdout.write(cur.pay + " ")
                final += [(cur,level)]
                q += [(cur.left, level + 1)]
                q += [(cur.right, level + 1)]
        print

def main():
    root = Tree("a")
    b = root.left = Tree("b")
    c = root.right = Tree("c", Tree("f"), Tree("g", Tree("bar")))
    d = b.left = Tree("d")
    e = b.right = Tree("e", Tree("foo"))
    root.print_by_line()

if __name__ == "__main__":
    main()