
import sys

def peek_file(path, lines=50):
    try:
        with open(path, 'r', encoding='utf-16') as f:
            for i, line in enumerate(f):
                if i >= lines:
                    break
                print(line.strip())
    except Exception as e:
        # Try utf-8 if utf-16 fails
        try:
            with open(path, 'r', encoding='utf-8') as f:
                for i, line in enumerate(f):
                    if i >= lines:
                        break
                    print(line.strip())
        except Exception as e2:
            print(f"Error reading file: {e} | {e2}")

if __name__ == "__main__":
    peek_file(sys.argv[1])
