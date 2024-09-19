import os
from os.path import isfile
from sys import version

class ConfigParser:
    #could be improved using os.isfile or error handling
    @classmethod
    def parse_section(cls, section:str, file_path:str)-> dict:
        if not os.path.isfile(file_path):
            return {}

        with open(file_path, "r") as file:
            lines = [item.replace("\n", "") for item in file.readlines()]
            try:
                desktop_section_index = lines.index(f"[{section}]")
                section_content = {}
                for line in lines[desktop_section_index+1:]:
                    if not "=" in line:
                        break
                    key, value = line.split("=", 1)
                    section_content[key] = value
                return section_content
            except ValueError:
                return {}

    
    @classmethod
    def parse_config(cls, file_path:str)->dict:
        if not os.path.exists(file_path):
            print("file does not exist")
            return {}
        
        with open(file_path, "r") as file:
            config_file = {}
            section = ""
            for line in file:
                line = line.strip()
                if line.startswith("[") and line.endswith("]"):
                    section = line[1:-1]
                    config_file[section] = {}
                elif "=" in line:
                    if section != "":
                        key, value = line.split("=", 1)
                        converted = cls.convert_bool(value)
                        config_file[section][key] = converted if converted is not None else value

        return config_file


    @classmethod
    def convert_bool(cls, bool_str:str):
        options={
                "true": True,
                "false": False
        }
        return options.get(bool_str)



