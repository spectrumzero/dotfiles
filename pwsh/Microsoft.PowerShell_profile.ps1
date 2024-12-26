# C:\Users\lmh22\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

#设置默认打开位置为当前工作目录
set-Location E:/lazycoding

# set env
$env:DATA = "C:/Users/lmh22/AppData/Local/"
$env:NVIM = "C:/Users/lmh22/AppData/Local/nvim"

# 使用utf8编码
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# 设置timeout容忍度
$env:POWERSHELL_COMMAND_TIMEOUT = 300000

# 使用starship主题
Invoke-Expression (&starship init powershell)

# starship主题的配置文件所在的路径，其实不在这里写，也会自动寻址到这里去。这里是告诉你要配置starship的话，就配置这个toml文件
$ENV:STARSHIP_CONFIG = "C:\Users\admin\.config\starship.toml"

# powershell初始化加载 PSReadLine 模块
Import-Module PSReadLine

# 使用历史记录进行脚本提示
Set-PSReadLineOption -PredictionSource History

# use terminal file manager "yazi"
# 配置当前工作目录随着yy的遍历而即时更新
function yy
{
  $tmp = [System.IO.Path]::GetTempFileName()
  yz $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
  {
    Set-Location -LiteralPath $cwd
  }
  Remove-Item -Path $tmp
}

# 别名
Set-Alias cl cls
Set-Alias ls Get-ChildItem -Force
Set-Alias vim nvim
Set-Alias touch New-Item
Set-Alias neo neovide
Set-Alias yz yazi
Set-Alias zd z

Invoke-Expression (& { (zoxide init powershell | Out-String) })
