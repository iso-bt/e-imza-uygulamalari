# KamuSM Kök sertifika dosyasının yenilenmesi
# E-imza işleminde kök sertifikanın güvenilirliği hatası alınırsa bu kod çözüm olacaktır.

$certFolderPath = "$env:USERPROFILE\.sertifikadeposu"

if (Test-Path -Path $certFolderPath) {
    Remove-Item -Path "$certFolderPath\SertifikaDeposu.svt" -Force
    Invoke-WebRequest -Uri "http://depo.kamusm.gov.tr/depo/SertifikaDeposu.svt" -OutFile "$certFolderPath\SertifikaDeposu.svt"
}
