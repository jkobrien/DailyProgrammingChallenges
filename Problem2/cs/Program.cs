using System;
using System.Collections.Generic;

namespace cs
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            TestFunction();
        }

        static void TestFunction()
        {
            List<int> ArrayOfNumbers = new List<int>{1,2,3,4,5};
            List<int> ArrayOfProducts = CheckList(ArrayOfNumbers);
            PrintResult(ArrayOfNumbers);
            PrintResult(ArrayOfProducts);

        }

        static List<int> CheckList(List<int> ArrayOfNumbers)
        {
            List<int> tempArrayOfProducts = new List<int>{};
            int lengthOfList = ArrayOfNumbers.Count;
            int resultValue = 1;
            int tempNumber = 0;
            int position = 0;
            foreach (int ArrayValue in ArrayOfNumbers)
            {
                for(int i=0; i < ArrayOfNumbers.Count; i ++)
                    {
                        if(position!=i)
                        {
                            tempNumber = ArrayOfNumbers[i];
                            resultValue = resultValue * tempNumber;
                        }
                    }
                tempArrayOfProducts.Add(resultValue);
                resultValue = 1;
            }
            return tempArrayOfProducts;
        }

        static void PrintResult(List<int> ArrayToPrint)
        {
            Console.Write("[");

            foreach (int i in ArrayToPrint)
            {
                Console.Write("{0} ",i);
            }
            Console.Write("]");
            Console.WriteLine();
        }
    }
}