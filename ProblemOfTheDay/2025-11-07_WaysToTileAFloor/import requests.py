import requests
from bs4 import BeautifulSoup
import re
from datetime import datetime

def fetch_geeksforgeeks_potd():
    """
    Fetch today's Problem of the Day from GeeksforGeeks
    """
    try:
        # GeeksforGeeks Problem of the Day URL
        url = "https://www.geeksforgeeks.org/problem-of-the-day"
        
        # Set headers to mimic a browser request
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }
        
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Extract problem title
        title_element = soup.find('h1') or soup.find('title')
        title = title_element.get_text().strip() if title_element else "Problem of the Day"
        
        # Extract problem description
        problem_desc = soup.find('div', class_='problems_problem_content__Xm_eO')
        if not problem_desc:
            problem_desc = soup.find('div', {'class': re.compile('problem.*content', re.I)})
        
        description = problem_desc.get_text().strip() if problem_desc else "Problem description not found"
        
        # Extract example if available
        example_section = soup.find('div', string=re.compile('Example', re.I))
        example = ""
        if example_section:
            example = example_section.find_next('div').get_text().strip() if example_section.find_next('div') else ""
        
        return {
            'title': title,
            'description': description,
            'example': example,
            'date': datetime.now().strftime('%Y-%m-%d')
        }
        
    except Exception as e:
        print(f"Error fetching problem: {e}")
        return None

def solve_problem(problem_data):
    """
    Template for solving the fetched problem
    Customize this function based on the specific problem
    """
    if not problem_data:
        return None
    
    print(f"Problem Title: {problem_data['title']}")
    print(f"Date: {problem_data['date']}")
    print("\nProblem Description:")
    print(problem_data['description'][:500] + "..." if len(problem_data['description']) > 500 else problem_data['description'])
    
    if problem_data['example']:
        print(f"\nExample: {problem_data['example']}")
    
    # Generic solution template - customize based on the actual problem
    def solution_template(input_data):
        """
        This is a template solution function.
        Replace this with the actual solution based on the problem requirements.
        
        Common problem patterns and their approaches:
        1. Array problems: Two pointers, sliding window, sorting
        2. String problems: Hash maps, two pointers, dynamic programming
        3. Tree problems: DFS, BFS, recursion
        4. Graph problems: DFS, BFS, Union-Find
        5. Dynamic Programming: Memoization, tabulation
        """
        
        # Example implementation structure
        result = None
        
        # Step 1: Parse input (customize based on problem)
        # Step 2: Apply algorithm (customize based on problem type)
        # Step 3: Return result
        
        return result
    
    return solution_template

# Example usage and common problem-solving patterns
def common_algorithms():
    """
    Common algorithms and data structures for competitive programming
    """
    
    # 1. Two Pointers Technique
    def two_pointers_example(arr, target):
        left, right = 0, len(arr) - 1
        while left < right:
            current_sum = arr[left] + arr[right]
            if current_sum == target:
                return [left, right]
            elif current_sum < target:
                left += 1
            else:
                right -= 1
        return []
    
    # 2. Sliding Window
    def sliding_window_example(arr, k):
        if len(arr) < k:
            return 0
        
        window_sum = sum(arr[:k])
        max_sum = window_sum
        
        for i in range(k, len(arr)):
            window_sum = window_sum - arr[i-k] + arr[i]
            max_sum = max(max_sum, window_sum)
        
        return max_sum
    
    # 3. Binary Search
    def binary_search(arr, target):
        left, right = 0, len(arr) - 1
        
        while left <= right:
            mid = (left + right) // 2
            if arr[mid] == target:
                return mid
            elif arr[mid] < target:
                left = mid + 1
            else:
                right = mid - 1
        
        return -1
    
    # 4. DFS for Trees/Graphs
    def dfs_recursive(graph, node, visited):
        visited.add(node)
        result = [node]
        
        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                result.extend(dfs_recursive(graph, neighbor, visited))
        
        return result
    
    return {
        'two_pointers': two_pointers_example,
        'sliding_window': sliding_window_example,
        'binary_search': binary_search,
        'dfs': dfs_recursive
    }

# Main execution
if __name__ == "__main__":
    print("Fetching today's Problem of the Day from GeeksforGeeks...")
    
    # Fetch the problem
    problem = fetch_geeksforgeeks_potd()
    
    if problem:
        # Get solution template
        solution_func = solve_problem(problem)
        
        print("\n" + "="*50)
        print("SOLUTION APPROACH:")
        print("="*50)
        print("""
        To solve this problem, follow these general steps:
        
        1. UNDERSTAND THE PROBLEM:
           - Read the problem statement carefully
           - Identify input/output format
           - Note constraints and edge cases
        
        2. ANALYZE THE PROBLEM:
           - Determine the problem type (array, string, tree, graph, etc.)
           - Identify the optimal algorithm/data structure
           - Consider time and space complexity
        
        3. IMPLEMENT THE SOLUTION:
           - Write clean, readable code
           - Handle edge cases
           - Test with examples
        
        4. OPTIMIZE:
           - Review for efficiency improvements
           - Consider alternative approaches
        """)
        
        # Display common algorithms
        algorithms = common_algorithms()
        print("\nCommon algorithm templates are available in the 'common_algorithms' function.")
        
    else:
        print("Failed to fetch the problem. Please check manually at: https://www.geeksforgeeks.org/problem-of-the-day")
        
    print("\nNote: Customize the solution_template function based on the specific problem requirements.")