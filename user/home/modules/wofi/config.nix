{opt-config, ...}:
{
  config = {
    style = "/home/${opt-config.username}/.config/wofi/style.css";
    width = "25%";
    height = "25%";
    always_parse_args = "true";
    show_all = "true";
    print_command = "true";
    layer = "overlay";
    insensitive = "true";
    prompt = "";
    normal-window = "false";
    cache-file = "true";
  };
  style = [
    {
      title = "window";
      content = {
        margin = "0px";
        border = "0px solid #2e3440";
        border-radius = "0px";
        background-color = "#3b4252";
        font-family = "Hack Nerd Font";
        font-size = "15px";
      };
    }
    {
      title = "#input";
      content = {
        margin = "5px";
        border = "2px solid #e0deda";
        color = "#eceff4";
        background-color = "#3b4252";
      };
    }
    {
      title = "#input image";
      content = {
      	color = "#eceff4";
      };
    }
    {
      title = "#inner-box";
      content = {
        margin = "5px";
        border = "none";
        background-color = "#3b4252";
      };
    }
    {
      title = "#outer-box";
      content = {
        margin = "5px";
        border = "none";
        background-color = "#3b4252";
      };
    }
    {
      title = "#scroll";
      content = {
        margin = "0px";
        border = "none";
      };
    }
    {
      title = "#text";
      content = {
        margin = "10px";
        border = "none";
        color = "#eceff4";
      };
    }
    {
      title = "#entry:selected";
      content = {
        background-color = "#87a96b";
        font-weight = "bold";
      };
    }
    {
      title = "#text:selected";
      content = {
        background-color = "#87a96b";
        font-weight = "bold";
      };
    }
  ];
}
