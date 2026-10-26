# BMR Calculator

Aplikasi kalkulator **BMR (Basal Metabolic Rate)** berbasis Flutter. Aplikasi ini dikembangkan dari kalkulator BMI sebagai tugas kelompok, dengan perhitungan yang diubah menjadi BMR dan kebutuhan kalori harian.

## Anggota Kelompok

| No | Nama | NIM |
|----|------|-----|
| 1 | Kania Adha Gayatri | K3524013 |
| 2 | Salsabila Fitriasani | K3524035 |
| 3 | Uswatun Chasanah | K3524083 |

## Deskripsi

BMR adalah perkiraan energi yang dibutuhkan tubuh saat istirahat untuk menjalankan fungsi dasar. Aplikasi ini menghitung BMR dari data pribadi pengguna, lalu mengalikannya dengan tingkat aktivitas untuk memperkirakan kebutuhan kalori harian.

**Fitur utama**

- Input jenis kelamin, umur, tinggi badan, dan berat badan dengan validasi.
- Tiga pilihan rumus BMR: Mifflin-St Jeor, Revised Harris-Benedict, dan Katch-McArdle (membutuhkan persentase lemak tubuh).
- Pilihan satuan hasil: kalori (kcal/hari) atau kilojoule (kJ/day).
- Tabel kebutuhan kalori harian untuk enam tingkat aktivitas, dari Sedentary sampai Extra active.

**Alur penggunaan**

1. Pengguna mengisi data di halaman input (`InputPage`).
2. Rumus dan satuan hasil dapat diubah lewat menu *Settings*.
3. Tombol *Calculate BMR* memvalidasi input, lalu `BMRCalculator` menghitung BMR.
4. Halaman hasil (`ResultPage`) menampilkan BMR dan tabel kebutuhan kalori harian.

**Struktur kode**

```
lib/
├── main.dart            # titik awal aplikasi dan tema
├── calculator.dart      # logika perhitungan BMR dan tingkat aktivitas
├── constants.dart       # warna, gaya teks, enum, dan dekorasi input
├── components/          # widget kecil yang dapat dipakai ulang
└── pages/
    ├── input_page.dart  # halaman formulir input
    └── result_page.dart # halaman hasil perhitungan
```

## Screenshot Aplikasi
<img width="365" height="805" alt="Input male 1" src="https://github.com/user-attachments/assets/fad64723-ff58-4bed-8725-32ffc55d4925" />
<img width="367" height="798" alt="Input male 2" src="https://github.com/user-attachments/assets/d2fa1e2a-5cd5-41da-b65c-fe1f25c4462a" />
<img width="365" height="807" alt="Input male 3" src="https://github.com/user-attachments/assets/3bd68fad-2467-4d64-8138-6d03b99dbdd9" />
<img width="372" height="796" alt="Result male 1" src="https://github.com/user-attachments/assets/d78c523f-b137-45bf-a1ff-8492903d447e" />
<img width="370" height="797" alt="Result male 2" src="https://github.com/user-attachments/assets/869c8b1e-5634-471a-979e-4f2d9cac2cd6" />
<img width="372" height="802" alt="Input Female 1" src="https://github.com/user-attachments/assets/233eed5c-00bf-491b-bdc6-ed9c713adba3" />
<img width="372" height="803" alt="Result Female 1" src="https://github.com/user-attachments/assets/a7374b47-2b75-4b5c-bb22-b014528b7478" />
<img width="370" height="802" alt="Result Female 2" src="https://github.com/user-attachments/assets/1006af38-af29-4560-8940-81389a3e80a6" />

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

Aplikasi ini menggunakan Flutter dengan Dart SDK `^3.13.1` dan paket `font_awesome_flutter`.

> Hasil perhitungan hanyalah estimasi dan bukan pengganti saran medis profesional.
