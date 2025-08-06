import argparse

def main():
    parser = argparse.ArgumentParser(description="Print the provided argument value.")
    parser.add_argument("--param", type=str, help="The optional parameter to print")
    args = parser.parse_args()

    print("=" * 50)
    print("Welcome to CI Test Script")
    print("=" * 50)

    if args.param:
        print(f"Received parameter: {args.param}")
    else:
        print("No parameter provided.")

    print("=" * 50)
    print("End of CI Test Script")
    print("=" * 50)

if __name__ == "__main__":
    main()