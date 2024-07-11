Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

#设置默认打开位置为当前工作目录
set-Location $pwd

# 使用utf8编码
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# 使用oh-my-posh主题
# & ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\nordtron.omp.json" --print) -join "`n"))

# 设置timeout容忍度
$env:POWERSHELL_COMMAND_TIMEOUT = 300000


# 使用starship时自定义的头
# function Invoke-Starship-PreCommand {
# $host.ui.Write("`e]0; PS> $env:USERNAME@$env:COMPUTERNAME`: $pwd `a")
#  $host.ui.Write("🎄 Hello Bourdieu!🎄")
# }

# 使用starship主题
Invoke-Expression (&starship init powershell)

# starship主题的配置文件所在的路径，其实不在这里写，也会自动寻址到这里去。这里是告诉你要配置starship的话，就配置这个toml文件
$ENV:STARSHIP_CONFIG = "C:\Users\admin\.config\starship.toml"

# powershell初始化加载 PSReadLine 模块
Import-Module PSReadLine

# 删除默认的连接（强制删除）
# Remove-Alias ls -Force
# Remove-Alias sl -Force

# 使用历史记录进行脚本提示
Set-PSReadLineOption -PredictionSource History

#tab菜单选择以及上下键补全以及emacs模式
Set-PSReadLineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# alt在windows中有特殊用途，这里使用ctrl键代替
Set-PSReadLineKeyHandler -Chord "Ctrl+RightArrow" -Function ForwardWord

# 自定义函数添加ls的颜色
function Color-List($str)
{
  $regex_opts = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase-bor [System.Text.RegularExpressions.RegexOptions]::Compiled)
  $fore = $Host.UI.RawUI.ForegroundColor
  $compressed = New-Object System.Text.RegularExpressions.Regex('\.(zip|tar|gz|rar|jar|war|7z)$', $regex_opts)
  $executable = New-Object System.Text.RegularExpressions.Regex('\.(exe|bat|cmd|py|ps1|psm1|vbs|rb|reg|sh|zsh)$', $regex_opts)
  $code_files = New-Object System.Text.RegularExpressions.Regex('\.(ini|csv|log|xml|yml|json|java|c|cpp|css|sass|js|ts|jsx|tsx|vue)$', $regex_opts)
  $head_files = New-Object System.Text.RegularExpressions.Regex('\.(h)$', $regex_opts)
  $itemList = @()
  Invoke-Expression ("Get-ChildItem" + " " + $str) | ForEach-Object {
    $item = New-Object object
    if ($_.GetType().Name -eq 'DirectoryInfo') 
    {
      $item | Add-Member NoteProperty name ("`e[34m" + $_.name) # 目录名称蓝色
    } elseif ($compressed.IsMatch($_.Name)) 
    {
      $item | Add-Member NoteProperty name ("`e[31m" + $_.name) # 压缩文件红色
    } elseif ($executable.IsMatch($_.Name))
    {
      $item | Add-Member NoteProperty name ("`e[36m" + $_.name) # 可执行文件青色
    } elseif ($code_files.IsMatch($_.Name))
    {
      $item | Add-Member NoteProperty name ("`e[33m" + $_.name) # 代码文件黄色
    } elseif ($head_files.IsMatch($_.Name))
    {
      $item | Add-Member NoteProperty name ("`e[32m" + $_.name) # 头文件绿色
    } else
    {
      $item | Add-Member NoteProperty name ("`e[37m" + $_.name) # 其他文件默认白色
    } 
    $itemList += $item
  }
  echo $itemList | Format-Wide -AutoSize # 格式化输出
}

# use terminal file manager "yazi"
Set-Alias yz yazi
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
Set-Alias vim nvim
Set-Alias touch New-Item
Set-Alias neo neovide
Set-Alias ranger lf
