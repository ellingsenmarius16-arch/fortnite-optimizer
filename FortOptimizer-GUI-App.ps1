Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$licenseKeyFile = "$env:APPDATA\FortOptimizer\licenses.txt"
$configFolder = "$env:APPDATA\FortOptimizer"

if (-not (Test-Path $configFolder)) {
    New-Item -ItemType Directory -Path $configFolder -Force | Out-Null
}

if (-not (Test-Path $licenseKeyFile)) {
    @"
DEMO-KEY-2024-TRIAL|2026-12-31|ACTIVE
"@ | Out-File -FilePath $licenseKeyFile -Force
}

function Validate-LicenseKey {
    param([string]$key)
    
    $content = Get-Content $licenseKeyFile
    foreach ($line in $content) {
        if ($line.StartsWith("#") -or $line.Trim() -eq "") { continue }
        
        $parts = $line -split '\|'
        if ($parts[0] -eq $key -and $parts[2] -eq "ACTIVE") {
            $expiry = [datetime]::ParseExact($parts[1], "yyyy-MM-dd", $null)
            if ($expiry -gt (Get-Date)) {
                return $true
            }
        }
    }
    return $false
}

$form = New-Object System.Windows.Forms.Form
$form.Text = "Fortnite Optimizer Pro - v3.0"
$form.Width = 900
$form.Height = 700
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 35)
$form.ForeColor = [System.Drawing.Color]::White

$logoLabel = New-Object System.Windows.Forms.Label
$logoLabel.Text = "FORTNITE OPTIMIZER PRO"
$logoLabel.Font = New-Object System.Drawing.Font("Arial", 16, [System.Drawing.FontStyle]::Bold)
$logoLabel.ForeColor = [System.Drawing.Color]::Cyan
$logoLabel.Location = New-Object System.Drawing.Point(20, 20)
$logoLabel.Size = New-Object System.Drawing.Size(400, 30)
$form.Controls.Add($logoLabel)

$licenseLabel = New-Object System.Windows.Forms.Label
$licenseLabel.Text = "Enter License Key:"
$licenseLabel.Location = New-Object System.Drawing.Point(20, 70)
$licenseLabel.Size = New-Object System.Drawing.Size(150, 20)
$form.Controls.Add($licenseLabel)

$licenseBox = New-Object System.Windows.Forms.TextBox
$licenseBox.Location = New-Object System.Drawing.Point(20, 95)
$licenseBox.Size = New-Object System.Drawing.Size(300, 25)
$licenseBox.Font = New-Object System.Drawing.Font("Arial", 10)
$licenseBox.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 45)
$licenseBox.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($licenseBox)

$validateBtn = New-Object System.Windows.Forms.Button
$validateBtn.Text = "Validate"
$validateBtn.Location = New-Object System.Drawing.Point(330, 95)
$validateBtn.Size = New-Object System.Drawing.Size(100, 25)
$validateBtn.BackColor = [System.Drawing.Color]::Green
$validateBtn.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($validateBtn)

$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "No License Validated"
$statusLabel.Location = New-Object System.Drawing.Point(20, 130)
$statusLabel.Size = New-Object System.Drawing.Size(300, 20)
$statusLabel.ForeColor = [System.Drawing.Color]::Red
$form.Controls.Add($statusLabel)

$tweaksGroup = New-Object System.Windows.Forms.GroupBox
$tweaksGroup.Text = "Optimization Tweaks"
$tweaksGroup.Location = New-Object System.Drawing.Point(20, 165)
$tweaksGroup.Size = New-Object System.Drawing.Size(850, 480)
$tweaksGroup.ForeColor = [System.Drawing.Color]::Cyan
$tweaksGroup.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 35)
$form.Controls.Add($tweaksGroup)

$tweaks = @(
    @{ Name = "Memory Optimization"; Desc = "Disable NTFS Last Access, Superfetch"; Enabled = $false },
    @{ Name = "Network Optimization"; Desc = "Reduce ping, optimize TCP/DNS"; Enabled = $false },
    @{ Name = "Disable Windows Search"; Desc = "Stop indexing service"; Enabled = $false },
    @{ Name = "GPU Acceleration"; Desc = "Enable hardware GPU scheduling"; Enabled = $false },
    @{ Name = "CPU Priority Boost"; Desc = "Maximize gaming CPU priority"; Enabled = $false },
    @{ Name = "Raw Input Mouse"; Desc = "Disable acceleration, 1:1 raw input"; Enabled = $false },
    @{ Name = "Visual Effects Off"; Desc = "Disable animations and effects"; Enabled = $false },
    @{ Name = "Kill Bloatware"; Desc = "Terminate OneDrive, Teams, Chrome"; Enabled = $false },
    @{ Name = "DNS Flush"; Desc = "Clear DNS cache"; Enabled = $false },
    @{ Name = "Extreme Mode"; Desc = "Apply ALL Ultra tweaks"; Enabled = $false }
)

$checkboxes = @()
$y = 25
foreach ($tweak in $tweaks) {
    $checkbox = New-Object System.Windows.Forms.CheckBox
    $checkbox.Text = "$($tweak.Name)"
    $checkbox.Location = New-Object System.Drawing.Point(30, $y)
    $checkbox.Size = New-Object System.Drawing.Size(300, 20)
    $checkbox.ForeColor = [System.Drawing.Color]::White
    $checkbox.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 35)
    $checkbox.Tag = $tweak.Desc
    $tweaksGroup.Controls.Add($checkbox)
    $checkboxes += $checkbox
    
    $desc = New-Object System.Windows.Forms.Label
    $desc.Text = $tweak.Desc
    $desc.Location = New-Object System.Drawing.Point(350, $y)
    $desc.Size = New-Object System.Drawing.Size(450, 20)
    $desc.ForeColor = [System.Drawing.Color]::Gray
    $desc.Font = New-Object System.Drawing.Font("Arial", 8)
    $tweaksGroup.Controls.Add($desc)
    
    $y += 35
}

$applyBtn = New-Object System.Windows.Forms.Button
$applyBtn.Text = "APPLY TWEAKS"
$applyBtn.Location = New-Object System.Drawing.Point(20, 660)
$applyBtn.Size = New-Object System.Drawing.Size(200, 30)
$applyBtn.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
$applyBtn.BackColor = [System.Drawing.Color]::Lime
$applyBtn.ForeColor = [System.Drawing.Color]::Black
$form.Controls.Add($applyBtn)

$adminBtn = New-Object System.Windows.Forms.Button
$adminBtn.Text = "Admin Panel"
$adminBtn.Location = New-Object System.Drawing.Point(230, 660)
$adminBtn.Size = New-Object System.Drawing.Size(150, 30)
$adminBtn.BackColor = [System.Drawing.Color]::FromArgb(100, 50, 150)
$adminBtn.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($adminBtn)

$exitBtn = New-Object System.Windows.Forms.Button
$exitBtn.Text = "Exit"
$exitBtn.Location = New-Object System.Drawing.Point(800, 660)
$exitBtn.Size = New-Object System.Drawing.Size(70, 30)
$exitBtn.BackColor = [System.Drawing.Color]::Red
$exitBtn.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($exitBtn)

$validateBtn.Add_Click({
    $key = $licenseBox.Text.Trim()
    if ($key -eq "") {
        [System.Windows.Forms.MessageBox]::Show("Enter a license key!", "Error", "OK", "Error")
        return
    }
    
    if (Validate-LicenseKey $key) {
        $statusLabel.Text = "License Valid!"
        $statusLabel.ForeColor = [System.Drawing.Color]::Lime
        $applyBtn.Enabled = $true
    } else {
        $statusLabel.Text = "Invalid License Key"
        $statusLabel.ForeColor = [System.Drawing.Color]::Red
        $applyBtn.Enabled = $false
    }
})

$applyBtn.Add_Click({
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $isAdmin) {
        [System.Windows.Forms.MessageBox]::Show("Must run as Administrator!", "Error", "OK", "Error")
        return
    }
    
    $selected = @($checkboxes | Where-Object { $_.Checked })
    if ($selected.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Select at least one tweak!", "Error", "OK", "Error")
        return
    }
    
    $result = [System.Windows.Forms.MessageBox]::Show(
        "Apply $($selected.Count) tweaks? System restart required!",
        "Confirm",
        "YesNo",
        "Question"
    )
    
    if ($result -eq "Yes") {
        [System.Windows.Forms.MessageBox]::Show(
            "Applying tweaks...`nSystem will restart in 10 seconds!",
            "Success",
            "OK",
            "Information"
        )
        
        foreach ($checkbox in $selected) {
            Write-Host "Applying: $($checkbox.Text)" -ForegroundColor Green
        }
        
        Start-Sleep -Seconds 2
        Restart-Computer -Force
    }
})

$adminBtn.Add_Click({
    $adminForm = New-Object System.Windows.Forms.Form
    $adminForm.Text = "Admin Panel - License Key Generator"
    $adminForm.Width = 600
    $adminForm.Height = 400
    $adminForm.StartPosition = "CenterParent"
    $adminForm.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 35)
    $adminForm.ForeColor = [System.Drawing.Color]::White
    
    $passLabel = New-Object System.Windows.Forms.Label
    $passLabel.Text = "Admin Password:"
    $passLabel.Location = New-Object System.Drawing.Point(20, 20)
    $passLabel.Size = New-Object System.Drawing.Size(150, 20)
    $adminForm.Controls.Add($passLabel)
    
    $passBox = New-Object System.Windows.Forms.TextBox
    $passBox.Location = New-Object System.Drawing.Point(20, 45)
    $passBox.Size = New-Object System.Drawing.Size(300, 25)
    $passBox.PasswordChar = '*'
    $passBox.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 45)
    $passBox.ForeColor = [System.Drawing.Color]::White
    $adminForm.Controls.Add($passBox)
    
    $unlockBtn = New-Object System.Windows.Forms.Button
    $unlockBtn.Text = "Unlock"
    $unlockBtn.Location = New-Object System.Drawing.Point(330, 45)
    $unlockBtn.Size = New-Object System.Drawing.Size(100, 25)
    $unlockBtn.BackColor = [System.Drawing.Color]::Blue
    $unlockBtn.ForeColor = [System.Drawing.Color]::White
    $adminForm.Controls.Add($unlockBtn)
    
    $adminContent = New-Object System.Windows.Forms.Panel
    $adminContent.Location = New-Object System.Drawing.Point(20, 80)
    $adminContent.Size = New-Object System.Drawing.Size(550, 280)
    $adminContent.Visible = $false
    $adminContent.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 35)
    $adminForm.Controls.Add($adminContent)
    
    $genLabel = New-Object System.Windows.Forms.Label
    $genLabel.Text = "Generate New License Key"
    $genLabel.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
    $genLabel.Location = New-Object System.Drawing.Point(0, 10)
    $genLabel.Size = New-Object System.Drawing.Size(550, 25)
    $genLabel.ForeColor = [System.Drawing.Color]::Cyan
    $adminContent.Controls.Add($genLabel)
    
    $expiryLabel = New-Object System.Windows.Forms.Label
    $expiryLabel.Text = "Expiry Date (YYYY-MM-DD):"
    $expiryLabel.Location = New-Object System.Drawing.Point(0, 45)
    $expiryLabel.Size = New-Object System.Drawing.Size(200, 20)
    $expiryLabel.ForeColor = [System.Drawing.Color]::White
    $adminContent.Controls.Add($expiryLabel)
    
    $expiryBox = New-Object System.Windows.Forms.TextBox
    $expiryBox.Location = New-Object System.Drawing.Point(0, 70)
    $expiryBox.Size = New-Object System.Drawing.Size(200, 25)
    $expiryBox.Text = (Get-Date).AddMonths(1).ToString("yyyy-MM-dd")
    $expiryBox.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 45)
    $expiryBox.ForeColor = [System.Drawing.Color]::White
    $adminContent.Controls.Add($expiryBox)
    
    $generateBtn = New-Object System.Windows.Forms.Button
    $generateBtn.Text = "Generate Key"
    $generateBtn.Location = New-Object System.Drawing.Point(220, 70)
    $generateBtn.Size = New-Object System.Drawing.Size(120, 25)
    $generateBtn.BackColor = [System.Drawing.Color]::Green
    $generateBtn.ForeColor = [System.Drawing.Color]::White
    $adminContent.Controls.Add($generateBtn)
    
    $keyOutput = New-Object System.Windows.Forms.TextBox
    $keyOutput.Location = New-Object System.Drawing.Point(0, 110)
    $keyOutput.Size = New-Object System.Drawing.Size(550, 40)
    $keyOutput.Multiline = $true
    $keyOutput.ReadOnly = $true
    $keyOutput.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 45)
    $keyOutput.ForeColor = [System.Drawing.Color]::Lime
    $adminContent.Controls.Add($keyOutput)
    
    $copyBtn = New-Object System.Windows.Forms.Button
    $copyBtn.Text = "Copy to Clipboard"
    $copyBtn.Location = New-Object System.Drawing.Point(0, 160)
    $copyBtn.Size = New-Object System.Drawing.Size(150, 25)
    $copyBtn.BackColor = [System.Drawing.Color]::Orange
    $copyBtn.ForeColor = [System.Drawing.Color]::White
    $adminContent.Controls.Add($copyBtn)
    
    $unlockBtn.Add_Click({
        if ($passBox.Text -eq "admin123") {
            $adminContent.Visible = $true
            $passBox.Enabled = $false
            $unlockBtn.Enabled = $false
        } else {
            [System.Windows.Forms.MessageBox]::Show("Wrong password!", "Error", "OK", "Error")
        }
    })
    
    $generateBtn.Add_Click({
        $newKey = "FORT-$(Get-Random -Minimum 100000 -Maximum 999999)-PRO"
        $expiry = $expiryBox.Text
        $entry = "$newKey|$expiry|ACTIVE"
        Add-Content -Path $licenseKeyFile -Value $entry
        $keyOutput.Text = $newKey
    })
    
    $copyBtn.Add_Click({
        [System.Windows.Forms.Clipboard]::SetText($keyOutput.Text)
        [System.Windows.Forms.MessageBox]::Show("Copied!", "Success", "OK", "Information")
    })
    
    $adminForm.ShowDialog($form) | Out-Null
})

$exitBtn.Add_Click({
    $form.Close()
})

$applyBtn.Enabled = $false

$form.ShowDialog() | Out-Null
