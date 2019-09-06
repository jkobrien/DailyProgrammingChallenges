using System;
using System.Collections.Generic;

namespace cs
{
    class Program
    {
        static void Main(string[] args)
        {
            TestFunction();
        }

        static void TestFunction()
        {
            List<int> ArrayOfNumbers = new List<int>{1, 2, -1,0};
            for (int i=1; i < int.MaxValue; i++)
            {
                if (!ArrayOfNumbers.Contains(i))
                {
                    Console.WriteLine("Lowest Positive Integer not in Array is {0}",i);
                    return;
                }
            }
        }
    }
}
