import json
import webbrowser
import subprocess
from typing import Optional, Dict, List

class BookmarkInterface:
    def __init__(self) -> None:
        self.bookmarks = self.process_bookmarks()

    def process_bookmarks(self, path: str = "/home/basti/.config/thorium/Default/Bookmarks") -> Optional[Dict]:
        bookmarks = self.get_bookmarks(path)
        if bookmarks:
            bookmark_data = self.construct_data(bookmarks)
            return bookmark_data
        else:
            print("No bookmarks found.")

    def get_bookmarks(self, path: str) -> Optional[List[Dict]]:
        try:
            with open(path, "r") as file:
                file_content = json.load(file)
        except FileNotFoundError:
            print(f"File not found: {path}")
            return None

        try:
            return file_content["roots"]["bookmark_bar"]["children"]
        except (KeyError, TypeError):
            print("Invalid bookmarks file format.")
            return None

    def construct_data(self, bookmarks: List[Dict]) -> Dict[str, str]:
        bookmark_data = {}
        for each in bookmarks:
            children = each.get("children")
            if children:
                for item in children:
                    bookmark_data[item.get("name", "")] = item.get("url", "")
            else:
                bookmark_data[each.get("name", "")] = each.get("url", "")
        return bookmark_data

    def show_menu(self) -> None:
        if self.bookmarks:
            content = "\n".join([item for item in self.bookmarks])
            result = subprocess.run(["rofi", "-dmenu", "-p", "Bookmarks"], input=content, text=True, capture_output=True)
            result = result.stdout.strip()
            url = self.bookmarks.get(result)
            self.open_link(url)
    def open_link(self, url) -> None:
        if url:
            subprocess.Popen(["xdg-open", url], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)





if __name__ == "__main__":
    BookmarkInterface().show_menu()

