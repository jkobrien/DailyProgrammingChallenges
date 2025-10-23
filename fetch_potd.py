import requests
import json
from datetime import datetime

def fetch_potd():
    url = "https://practiceapi.geeksforgeeks.org/api/v1/problems-of-day/problem/today"
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    }
    
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        
        data = response.json()
        if 'problem' in data:
            prob = data['problem']
            print(f"Title: {prob['title']}")
            print("-" * 50)
            print("Problem Statement:")
            print(prob['problem_statement'])
            print("\nExample:")
            print(prob['example'])
            print("\nConstraints:")
            print(prob['constraints'])
            
            # Save to README.md
            today = datetime.now().strftime('%Y-%m-%d')
            problem_dir = f"ProblemOfTheDay/{today}_{''.join(prob['title'].split())}"
            
            return {
                'title': prob['title'],
                'statement': prob['problem_statement'],
                'example': prob['example'],
                'constraints': prob['constraints'],
                'dir': problem_dir
            }
    except Exception as e:
        print(f"Error fetching problem: {e}")
        return None

if __name__ == "__main__":
    fetch_potd()
