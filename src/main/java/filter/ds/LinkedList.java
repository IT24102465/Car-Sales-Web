package filter.ds;

public class LinkedList<T> {
    private LinkedListNode<T> head;
    private int size = 0;

    public void add(T data) {
        LinkedListNode<T> newNode = new LinkedListNode<>(data);
        if (head == null) {
            head = newNode;
        } else {
            LinkedListNode<T> current = head;
            while (current.getNext() != null) {
                current = current.getNext();
            }
            current.setNext(newNode);
        }
        size++;
    }

    public T get(int index) {
        if (index < 0 || index >= size) throw new IndexOutOfBoundsException();
        LinkedListNode<T> current = head;
        for (int i = 0; i < index; i++) {
            current = current.getNext();
        }
        return current.getData();
    }

    public void remove(int index) {
        if (index < 0 || index >= size) throw new IndexOutOfBoundsException();
        if (index == 0) {
            head = head.getNext();
        } else {
            LinkedListNode<T> prev = head;
            for (int i = 0; i < index - 1; i++) {
                prev = prev.getNext();
            }
            prev.setNext(prev.getNext().getNext());
        }
        size--;
    }

    public int size() {
        return size;
    }

    public LinkedList<T> subList(int fromIndex, int toIndex) {
        LinkedList<T> newList = new LinkedList<>();
        LinkedListNode<T> current = head;
        for (int i = 0; i < fromIndex; i++) {
            current = current.getNext();
        }
        for (int i = fromIndex; i < toIndex; i++) {
            newList.add(current.getData());
            current = current.getNext();
        }
        return newList;
    }

    public LinkedListIterator iterator() {
        return new LinkedListIterator();
    }

    public class LinkedListIterator {
        private LinkedListNode<T> current = head;

        public boolean hasNext() {
            return current != null;
        }

        public T next() {
            if (!hasNext()) throw new RuntimeException("No more elements");
            T data = current.getData();
            current = current.getNext();
            return data;
        }
    }
} 