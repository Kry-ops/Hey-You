# Dokumentasi Struktur Halaman Test MBTI — Hey, You!

## 1. Deskripsi Fitur

Halaman **Test MBTI** merupakan fitur dalam aplikasi Hey, You! yang digunakan untuk membantu pengguna mengenali kecenderungan kepribadian berdasarkan empat dimensi MBTI.

Fitur ini memiliki:
- 60 pertanyaan kepribadian.
- 5 pilihan jawaban untuk setiap pertanyaan.
- Animasi teks saat pertanyaan ditampilkan.
- Animasi curtain reveal pada kartu tertentu.
- Halaman jeda setiap 20 pertanyaan.
- Perhitungan hasil berdasarkan empat dimensi MBTI.
- 16 kemungkinan tipe kepribadian.
- Halaman hasil yang menampilkan tipe dan persentase kecenderungan.
- Dekorasi visual berupa ilustrasi kucing dan elemen pendukung.

## 2. Struktur Folder

```text
lib/
├── pages/
│   └── test_mbti_page.dart
│
├── core/
│   ├── app_colors.dart
│   ├── app_text.dart
│   └── app_assets.dart
│
├── model/
│   └── mbti_data.dart
│
├── utils/
│   └── mbti_layout.dart
│
└── widgets/
    ├── asset_or_icon.dart
    │
    └── mbti_widgets/
        ├── curtain_reveal.dart
        ├── mbti_answer_option.dart
        ├── mbti_cards.dart
        ├── mbti_decorations.dart
        ├── mbti_next_bar.dart
        ├── mbti_progress.dart
        └── mbti_top_bar.dart
```

## 3. Fungsi Setiap File

### A. Halaman Utama

**`pages/test_mbti_page.dart`**

File utama yang mengatur keseluruhan alur tes MBTI.

Tanggung jawab:
- Mengelola state halaman menggunakan `StatefulWidget`.
- Mengatur indeks pertanyaan yang sedang ditampilkan.
- Menyimpan jawaban pengguna selama tes berlangsung.
- Mengatur perpindahan dari halaman pembuka ke pertanyaan, jeda, dan hasil.
- Mengatur kapan animasi dan komponen tertentu ditampilkan.
- Memproses jawaban ketika pengguna menekan tombol lanjut.
- Memanggil fungsi perhitungan hasil MBTI.
- Mengirim hasil perhitungan ke kartu hasil.
- Mengatur interaksi tombol atas dan tombol bawah.

File ini bertindak sebagai **pengendali utama (controller) alur halaman**, sedangkan tampilan komponennya dibagi ke dalam file widget terpisah.

### B. Core

**`core/app_colors.dart`**

Menyimpan konfigurasi warna yang digunakan bersama oleh aplikasi.

Tujuan:
- Menjaga konsistensi warna antarkomponen.
- Memudahkan perubahan tema tanpa mencari kode warna di banyak file.
- Menghindari deklarasi warna yang berulang.

**`core/app_text.dart`**

Menyimpan pengaturan atau gaya teks yang digunakan dalam aplikasi, seperti tipografi dan format teks yang konsisten.

**`core/app_assets.dart`**

Menyimpan referensi aset yang digunakan oleh fitur MBTI, seperti gambar, ilustrasi, ikon, dan dekorasi.

Dengan pemusatan aset, perubahan lokasi atau nama aset lebih mudah dikelola.

### C. Model Data

**`model/mbti_data.dart`**

Menyimpan data yang digunakan dalam proses tes dan hasil MBTI.

Data yang berkaitan dengan file ini meliputi:
- Daftar pertanyaan beserta dimensi atau kecenderungan jawabannya.
- Data hasil untuk 16 tipe kepribadian.
- Struktur data jawaban atau hasil perhitungan yang digunakan bersama.
- Data pasangan dimensi MBTI dan nama masing-masing dimensi.

File model digunakan agar data tidak tercampur dengan kode yang bertugas menggambar tampilan.

### D. Utilities

**`utils/mbti_layout.dart`**

Menyimpan konfigurasi ukuran dan tata letak komponen MBTI.

Contoh pengaturan:
- Lebar konten.
- Jarak antarelemen.
- Tinggi indikator progres.
- Radius sudut kartu.
- Ukuran tombol jawaban.
- Ukuran dan posisi dekorasi.
- Ukuran komponen lainnya.

Tujuannya adalah mempermudah penyesuaian desain dari satu tempat.

### E. Widgets MBTI

**`widgets/mbti_widgets/curtain_reveal.dart`**

Mengatur animasi *curtain reveal*, yaitu animasi kartu yang seolah-olah terbuka seperti tirai.

Digunakan untuk memberikan transisi visual ketika komponen tertentu muncul.

**`widgets/mbti_widgets/mbti_answer_option.dart`**

Mengatur tampilan satu pilihan jawaban.

Tanggung jawab:
- Menampilkan label jawaban.
- Menampilkan kondisi jawaban yang dipilih.
- Menangani interaksi pengguna pada pilihan jawaban.
- Menampilkan gaya visual sesuai kondisi komponen.

**`widgets/mbti_widgets/mbti_cards.dart`**

Berisi komponen kartu utama dalam tes MBTI.

Komponen yang terdapat di dalamnya:
- `IntroCard`: kartu pengenalan sebelum tes dimulai.
- `QuestionCard`: kartu pertanyaan dan pilihan jawaban.
- `RestCard`: kartu jeda di antara kelompok pertanyaan.
- `ResultCard`: kartu hasil akhir tes MBTI.

Kartu pertanyaan juga mengatur animasi mengetik untuk menampilkan teks secara bertahap.

**`widgets/mbti_widgets/mbti_decorations.dart`**

Mengatur elemen dekoratif yang memperkuat tampilan halaman, seperti ilustrasi dan ornamen pendukung.

**`widgets/mbti_widgets/mbti_next_bar.dart`**

Mengatur komponen bagian bawah halaman yang digunakan untuk tindakan seperti memulai tes, melanjutkan pertanyaan, atau menyelesaikan tes.

**`widgets/mbti_widgets/mbti_progress.dart`**

Mengatur indikator progres pengerjaan tes agar pengguna mengetahui perkembangan tes yang sedang berlangsung.

**`widgets/mbti_widgets/mbti_top_bar.dart`**

Mengatur komponen bagian atas halaman, seperti tombol kembali dan tombol menu.

**`widgets/asset_or_icon.dart`**

Widget pendukung untuk menampilkan aset ikon dengan ikon alternatif apabila aset tidak dapat ditampilkan.

## 4. Alur Halaman

```text
         MULAI TES MBTI
                |
                v
          IntroCard
                |
        Pengguna menekan Mulai
                |
                v
         QuestionCard
                |
       Pengguna memilih jawaban
                |
                v
       Validasi pilihan jawaban
                |
                v
      Simpan dan proses jawaban
                |
         +------+------+
         |             |
     Belum selesai   Sudah mencapai
         |           batas 20 soal
         |             |
         |             v
         |          RestCard
         |             |
         |       Lanjutkan tes
         |             |
         +------<------+
                |
                v
       Semua 60 soal selesai
                |
                v
       Hitung hasil kepribadian
                |
                v
            ResultCard
                |
                v
         Hasil tes ditampilkan
```

Catatan: diagram tersebut menggambarkan alur umum fitur. Detail perpindahan halaman dan kondisi animasi mengikuti implementasi di `test_mbti_page.dart`.

## 5. Sistem Pertanyaan dan Jawaban

Tes MBTI menggunakan total **60 pertanyaan**, dengan lima pilihan jawaban pada setiap pertanyaan.

Label pilihan jawaban:

1. Sangat Menggambarkan Dirimu
2. Cukup Menggambarkan Dirimu
3. Di Antara Keduanya
4. Kurang Menggambarkan Dirimu
5. Tidak Menggambarkan Dirimu

Jawaban dikonversi menjadi skor dari `+2` sampai `-2`.

| Pilihan | Skor |
|---|---:|
| Sangat menggambarkan | +2 |
| Cukup menggambarkan | +1 |
| Di antara keduanya | 0 |
| Kurang menggambarkan | -1 |
| Tidak menggambarkan | -2 |

Arah skor terhadap dimensi MBTI ditentukan oleh data atau kunci jawaban masing-masing pertanyaan.

## 6. Empat Dimensi MBTI

Hasil tes ditentukan berdasarkan empat pasangan dimensi berikut.

| Dimensi | Pilihan pertama | Pilihan kedua |
|---|---|---|
| Energi | E — Extraversion | I — Introversion |
| Informasi | S — Sensing | N — Intuition |
| Keputusan | T — Thinking | F — Feeling |
| Gaya hidup | J — Judging | P — Perceiving |

Satu huruf dipilih dari setiap pasangan sehingga menghasilkan salah satu dari 16 tipe kepribadian.

Contoh: `INTJ`, `INFP`, `ENFP`, dan `ESTJ`.

Dalam implementasi yang digunakan, apabila skor suatu pasangan seimbang, kecenderungan kedua dalam pasangan tersebut dipilih. Contohnya, hasil `I` dipilih ketika skor `E` dan `I` seimbang.

## 7. Sistem Jeda dan Progres

Tes dibagi menjadi tiga kelompok yang masing-masing berisi 20 pertanyaan.

- Setelah pertanyaan ke-20, pengguna memasuki halaman jeda.
- Setelah pertanyaan ke-40, pengguna memasuki halaman jeda.
- Setelah pertanyaan ke-60, tes berakhir dan hasil ditampilkan.

Halaman jeda menggunakan `RestCard`, sedangkan progres ditampilkan melalui widget progres.

Tinggi kartu perlu dijaga tetap konsisten agar perpindahan antara kartu pertanyaan, kartu jeda, dan kartu hasil tidak menyebabkan perubahan tata letak yang mengganggu.

## 8. Sistem Hasil

Setelah seluruh pertanyaan dijawab, halaman utama memproses skor dan menentukan empat huruf tipe kepribadian.

Hasil kemudian diberikan kepada `ResultCard`, yang bertanggung jawab menampilkan informasi hasil.

Bagian hasil dapat mencakup:
- Kode tipe kepribadian.
- Nama atau julukan tipe.
- Deskripsi kepribadian.
- Persentase kecenderungan pada setiap pasangan dimensi.

Persentase merupakan representasi hasil perhitungan aplikasi. Persentase tersebut tidak otomatis berarti hasil tes merupakan diagnosis psikologis atau ukuran kepribadian yang tervalidasi secara klinis.

## 9. Prinsip Pemisahan Kode

Struktur fitur MBTI menggunakan pembagian tanggung jawab berikut:

| Bagian | Tanggung jawab |
|---|---|
| `pages/` | Mengatur alur dan state halaman |
| `core/` | Menyimpan konfigurasi bersama |
| `model/` | Menyimpan struktur dan data tes |
| `utils/` | Menyimpan konfigurasi tata letak |
| `widgets/` | Menyimpan komponen antarmuka yang dapat digunakan kembali |

Pemisahan ini bertujuan agar:
- Kode utama tidak terlalu panjang.
- Perubahan desain tidak selalu membutuhkan perubahan logika.
- Data pertanyaan dan hasil lebih mudah dikelola.
- Komponen visual lebih mudah diperbaiki dan dikembangkan.
- Pemeliharaan fitur menjadi lebih terstruktur.

## 10. Catatan Pengembangan Berikutnya

Beberapa hal yang dapat dikembangkan lebih lanjut:

- Menyimpan hasil tes ke halaman Profile.
- Menyimpan riwayat tes agar hasil sebelumnya dapat dilihat kembali.
- Memisahkan algoritma perhitungan hasil ke file khusus apabila logikanya semakin kompleks.
- Menambahkan pengujian untuk memastikan skor dan hasil tipe MBTI konsisten.
- Meninjau validitas pertanyaan dan metode skoring sebelum hasil digunakan untuk interpretasi kepribadian yang lebih serius.

---

**Dokumen:** Struktur Fitur Test MBTI  
**Proyek:** Hey, You!  
**Framework:** Flutter  
**Bahasa:** Dart