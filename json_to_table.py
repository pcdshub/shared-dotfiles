
import json
import sys

import prettytable

from typing import Any, List, Optional


def string_for_table(value: Any, max_length: int = 80) -> str:
    """Fix the value for display in the table."""
    if isinstance(value, list):
        result = ", ".join(string_for_table(v) for v in value)
    else: 
        result = str(value)

    if len(result) > max_length:
        return result[:max_length] + "..."
    return result[:max_length]


def table_from_json(
    data: List[dict], sort_key: str, columns: Optional[List[str]] = None
) -> prettytable.PrettyTable:
    """Create a PrettyTable from the input JSON data."""
    table = prettytable.PrettyTable()
    table.field_names = columns
    for item in sorted(data, key=lambda item: item.get(sort_key, "?")):
        table.add_row(
            [string_for_table(item.get(key, "")) for key in table.field_names]
        )

    return table


def main(json_str: str, sort_key: str, columns: Optional[List[str]] = None):
    data = json.loads(json_str)
    table = table_from_json(data, sort_key=sort_key, columns=columns)
    print(table)


if __name__ == "__main__":
    main(sys.stdin.read(), sort_key=sys.argv[1], columns=sys.argv[1:])
