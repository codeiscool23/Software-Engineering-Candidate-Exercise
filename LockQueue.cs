using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;

/// <summary>
/// Summary description for LockQueue:
/// This is a thread safe queue that has a push and a pop method. 
/// </summary>
public class LockQueue<T>
{
        // constructor for new queue object to hold pushed items
        private Queue<T> queue = new Queue<T>();
        //parameter for max queue size
        private int maxSize;
        //constructor for this object with maxsize parameter setter
        public LockQueue(int maxSize) { this.maxSize = maxSize; }

        //method for adding items to the queue
        public void Push(T item)
        {
            //lock keyword ensures that one thread does not enter
            //a critical section of code while another thread is in the critical section.
            lock (queue)
            {
                //while the count of the queue is greater or equal to the max size
                while (queue.Count >= maxSize)
                {
                    //synchronize access to objects
                    //release the lock on object and blocks current thread until it reacquires the lock
                    Monitor.Wait(queue);
                }
                //adds an object to the end
                queue.Enqueue(item);
                //checks count
                if (queue.Count == 1)
                {
                    // wake up any blocked dequeue
                    Monitor.PulseAll(queue);
                }
            }
        }
        public T Pop()
        {
            lock (queue)
            {
                //while the count of the queue is 0
                while (queue.Count == 0)
                {
                    Monitor.Wait(queue);
                }
                //removes and returns the items at the beginning of the queue
                T item = queue.Dequeue();
                //if there is more room in the queue
                if (queue.Count == maxSize - 1)
                {
                    // wake up any blocked enqueue
                    Monitor.PulseAll(queue);
                }
                return item;
            }
        }
    }
