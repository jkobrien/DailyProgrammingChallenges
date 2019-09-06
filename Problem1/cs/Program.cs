using System;
using System.Collections.Generic;

namespace cs
{
    class Program
    {
        static int ActualResult = 0;
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            TestFunction();
        }

        static int GetExpectedResult(List<int> ArrayOfNumbers)
        {
            int Result = 0;
            int ListElementCount = ArrayOfNumbers.Count;
            for(int x=0; x < ListElementCount; x++)
            {
                for(int y=x+1; y < ListElementCount; y++)
                {
                    Result++;
                }
            }
            return Result;
        }

        static void TestFunction()
        {
            ActualResult = 0;
            List<int> ArrayOfNumbers = new List<int>{10, 15, 3, 7, 22, 67, 29, 67, 45 , 98 , 54};
            for(int testValue = 1; testValue <= 1000; testValue++)
            {
                bool returnValue = CheckList(ArrayOfNumbers, testValue);
            }
            int result = GetExpectedResult(ArrayOfNumbers);
            Console.WriteLine("Expected Result: {0}",result);
            Console.WriteLine("Actual Result: {0}",ActualResult);
        }

        static bool CheckList(List<int> ArrayOfNumbers, int NumberToCheck)
        {
            bool returnValue = false;
            int lengthOfList = ArrayOfNumbers.Count;
            int testValue;
            for(int x=0; x < lengthOfList; x++)
            {
                for(int y=x+1; y < lengthOfList; y++)
                {
                    testValue = ArrayOfNumbers[x] + ArrayOfNumbers[y];
                    if (NumberToCheck == testValue)
                    {
                        PrintSuccess(ArrayOfNumbers[x], ArrayOfNumbers[y], testValue);
                        ActualResult++;
                        returnValue = true;
                        return returnValue;
                    }
                }   
            }
            return returnValue;
        }

        static void PrintSuccess(int FirstNum, int SecondNum, int Total)
        {
            Console.WriteLine("TRUE for {0} + {1} = {2}", FirstNum, SecondNum, Total);
        }
    }
}
