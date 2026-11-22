# myportfolio_mobile

Nama: Anindya Raihani Hassan

NPM: 2506553295

Kelas: PBP B

Figma: https://www.figma.com/design/GbtLMAhuBI0FiiGeYQWRNa/Untitled?node-id=0-1&t=FBWVpnpO24HtdG9s-1

## Fitur

- 3 `InfoCard`: NPM, name, class.
- 5 `ItemCard` dengan icon dan warna unik per topik:
  - Skills: View Skills dan Add Skill (green)
  - Experiences: View Experiences dan Add Experience (purple)
  - Logout (red)
- SnackBar: muncul saat suatu tombol ditekan.

## Cara menjalankan

```bash
# 1. Clone repositori
git clone https://github.com/anindyou/myportfolio_mobile.git
cd myportfolio_mobile

# 2. Pasang dependency
flutter pub get

# 3. Jalankan aplikasi
flutter run -d chrome

# 4. (Opsional) Cek kualitas kode
flutter analyze
```

### Catatan

`GoogleFonts.cascadiaCodeTextTheme` baru tersedia di `google_fonts` 7.0.0 ke atas.

## Tugas 7: Pertanyaan Reflektif

### 1. Widget Tree

Widget Tree adalah struktur hierarki (seperti pohon) yang berisi widget pembentuk antarmuka pengguna (UI). Setiap widget menempati posisi sebagai parent atau child, di mana widget parent mengatur konfigurasi, tata letak, atau membungkus widget child di bawahnya.

### 2. Widget yang Digunakan dan Fungsinya

#### Struktur dan Aplikasi

| Widget                  | Fungsi                                                                        |
| ----------------------- | ----------------------------------------------------------------------------- |
| `MaterialApp`           | Root aplikasi. Mengatur tema, judul, dan halaman awal (`home`).               |
| `Scaffold`              | Kerangka dasar satu halaman. Menjadi wadah `body` dan tempat SnackBar muncul. |
| `SafeArea`              | Menjaga konten tidak tertutup notch dan/atau status bar.                      |
| `SingleChildScrollView` | Membuat konten bisa di-scroll sehingga tidak overflow di layar kecil.         |

#### Layout

| Widget      | Fungsi                                                                                                              |
| ----------- | ------------------------------------------------------------------------------------------------------------------- |
| `Column`    | Menyusun child secara vertikal, baik untuk keseluruhan halaman utama maupun di dalam `ItemCard`.                    |
| `Row`       | Menyusun child secara horizontal (baris tombol, isi `InfoCard`, dan isi tombol Logout).                             |
| `Expanded`  | Membuat child di dalam `Row` atau `Column` mengisi sisa ruang. Dipakai agar dua `ItemCard` membagi lebar sama rata. |
| `Flexible`  | Dipakai di `InfoCard` agar teks panjang tidak overflow.                                                             |
| `SizedBox`  | Memberi jarak tetap antar widget.                                                                                   |
| `Padding`   | Memberi jarak kosong di sekeliling child.                                                                           |
| `Container` | Di `InfoCard` dipakai untuk padding, warna latar, dan border.                                                       |

#### Tampilan dan Interaksi

| Widget              | Fungsi                                                       |
| ------------------- | ------------------------------------------------------------ |
| `Text`              | Menampilkan teks (judul, bio, label, isi card).              |
| `Icon`              | Menampilkan ikon pada tombol.                                |
| `DecoratedBox`      | Memberi dekorasi di luar card (efek glow lewat `BoxShadow`). |
| `Material`          | Menjadi latar dan bentuk card agar ripple `InkWell` muncul.  |
| `InkWell`           | Membuat area bisa ditekan dan memberi efek ripple (`onTap`). |
| `SnackBar`          | Pesan singkat di bawah layar saat suatu tombol ditekan.      |
| `ScaffoldMessenger` | Menampilkan dan menutup SnackBar.                            |

#### Lainnya

| Widget       | Fungsi                                   |
| ------------ | ---------------------------------------- |
| `MyApp`      | Widget root yang berisi `MaterialApp`.   |
| `MyHomePage` | Halaman utama yang menyusun seluruh isi. |
| `InfoCard`   | Kartu info (NPM, name, class).           |
| `ItemCard`   | Kartu action button.                     |

### 3. MaterialApp

`MaterialApp` adalah widget yang membungkus seluruh aplikasi dan menyiapkan hal-hal dasar Material Design:

- **Tema:** `theme` menentukan warna dan font untuk seluruh aplikasi.
- **Halaman awal dan navigasi:** `home` menentukan halaman pertama, dan `MaterialApp` juga menyediakan `Navigator` untuk berpindah halaman.
- **Layanan bagi widget di bawahnya:** menyediakan `Theme`, `Navigator`, `MediaQuery`, dan `ScaffoldMessenger`.

`MaterialApp` umum dipakai sebagai root karena semua widget di bawahnya bergantung pada layanan tersebut. Misalnya `Scaffold` membutuhkan konteks Material dan `ScaffoldMessenger.of(context)` membutuhkan `ScaffoldMessenger` yang sudah terpasang. Tanpa `MaterialApp` di root, widget-widget itu akan error atau tampil tidak sesuai.

### 4. StatelessWidget dan StatefulWidget

Perbedaan utama antara Stateless Widget dan Stateful Widget terletak pada kemampuan masing-masing dalam mengelola perubahan data atau kondisi (state) setelah widget ditampilkan di layar. Stateless Widget bersifat statis dan tidak dapat diubah, sehingga tampilannya akan selalu tetap selama aplikasi berjalan. Widget ini hanya membutuhkan satu kelas (StatelessWidget) dan ideal digunakan untuk komponen antarmuka yang hanya menampilkan informasi tetap tanpa memerlukan pembaruan interaktif, seperti Text, Icon, atau gambar statis.

Sebaliknya, Stateful Widget bersifat dinamis karena mampu menyimpan dan mengubah kondisinya seiring waktu sebagai respons terhadap interaksi pengguna maupun pembaruan data. Struktur widget ini membutuhkan dua kelas, yaitu kelas utama StatefulWidget dan kelas pendamping State. Digunakan jika komponen harus berubah akibat interaksi atau waktu misalnya seperti input form, counter, checkbox, animasi, dan sebagainya.

### 5. BuildContext

`BuildContext` adalah objek yang digunakan Flutter untuk memberikan informasi tentang lokasi widget dalam widget tree.

Di dalam metode `build`, context dipakai untuk memanggil `.of(context)`, contohnya:

- `Theme.of(context).textTheme` mengambil gaya teks dari tema di `MaterialApp`.
- `ScaffoldMessenger.of(context)` mencari `ScaffoldMessenger` di atas widget untuk menampilkan SnackBar.

Setiap widget punya context sendiri, dan pencarian dilakukan ke arah atas dari posisinya. Karena itu widget yang dicari harus berada di atasnya di dalam tree.

### 6. Hot Reload dan Hot Restart

**Hot reload** menyuntikkan (inject) perubahan kode ke aplikasi yang sedang berjalan tanpa menghentikan aplikasi lalu membangun ulang widget. **State tetap dipertahankan**, sehingga cepat dan cocok untuk mengubah tampilan.

**Hot restart** memuat ulang seluruh kode dan menjalankan ulang aplikasi dari `main()`. **State hilang** dan kembali ke kondisi awal, tetapi tetap lebih cepat daripada menutup dan membuka aplikasi lagi.

Hot reload tidak cukup dan perlu hot restart ketika:

- Mengubah nilai awal variabel atau state global.
- Perubahan di luar fungsi build(): Mengubah logic `initState()`
- Mengubah struktur class atau enum.
- Mereset alur aplikasi dari awal.

Full restart diperlukan saat:

- Menambah atau mengubah konfigurasi dependency di `pubspec.yaml`
- Mengubah kode native atau konfigurasi platform, seperti izin di `AndroidManifest.xml`.

## Tugas 7: AI Disclosure

Melalui desain yang saya buat di Figma, Claude membantu mencocokkan desain dengan ketentuan tugas dan memberikan saran revisi, menulis versi pertama menu.dart dan main.dart, menjelaskan error (google_fonts, lint prefer_const_constructors_in_immutables), mengoreksi komentar kode yang saya tulis, membantu verifikasi jawaban pertanyaan reflektif, dan merapikan format README (struktur tabel).

Keterbatasan yang saya temui: Claude tidak bisa memverifikasi lingkungan saya, sehingga GoogleFonts.cascadiaCodeTextTheme gagal dikompilasi karena versi google_fonts saya tidak compatible. Karena itu saya mengerjakan sendiri bagian berikut: desain awal dan penamaan warna di Figma, pemilihan gaya neon outline dan susunan tombol, dan penyesuaian kode agar mengikuti tutorial (final, textTheme, AppColors di menu.dart).

## Tugas 8: Pertanyaan Reflektif

### 1. Navigator

- `Navigator.push()` berfungsi menambahkan route baru ke bagian paling atas stack halaman yang sudah ada. Jadi halaman saat ini tetap ada di bawah halaman baru.
- `Navigator.pushReplacement()` berfungsi mengganti halaman yang sedang aktif di posisi teratas stack dengan halaman baru. Jadi halaman saat ini dihapus dan ditimpa halaman baru.
- `Navigator.pop()` berfungsi Menghapus atau mengeluarkan halaman yang sedang aktif (paling atas) dari stack. Jadi pengguna balik ke halaman yang persis di bawahnya.
- Metode yang digunakan untuk membuka form dari item card adalah `Navigator.push()` yang terlihat pada kode di bawah ini:

```
if (item.name == "Add Skill") {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SkillFormPage(),
    ),
  );
}
```

- Opsi home di drawer ketika dipencet (`onTap`) memiliki fungsi seperti ini:

```
onTap: () {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const MyHomePage(),
    ),
  );
},
```

`onTap` menggunakan `pushReplacement` dan route akan langsung di arahkan ke `MyHomePage`. Jadi, halaman atau route apapun yang sedang dilihat pengguna sekarang akan langsung dihapus kemudian digantikan dengan halaman `MyHomePage`.

### 2. Susunan struktur halaman

`Scaffold` adalah kerangka dasar halaman yang menyediakan `appBar`, `drawer`, `body`, dan `backgroundColor` untuk seluruh halaman. Karena setiap halaman memakai kerangka yang sama, posisi appbar, icon, dan area konten akan selalu konsisten.

`AppBar` memakai `backgroundColor: AppColors.background` dan `foregroundColor: AppColors.white` di semua halaman, jadi tampilannya menyatu dengan latar halaman.

`Drawer` dibuat sekali dalam widget `LeftDrawer`, lalu dipasang lewat drawer: `const LeftDrawer()` di setiap halaman. Menu navigasi yaitu Home, Add Skill, dan Add Experience selalu sama jadi hanya perlu diubah di satu tempat.

Salah satu contoh penggunaan warna tema di lebih dari satu halaman adalah penggunaan `AppColors.green` di `menu.dart` sebagai border card Add Skill. Warna ini kemudian dipakai lagi di `skill_form.dart` sebagai border field saat fokus, tombol Save, dan border dialog.

### 3. Tata letak formulir

Form disusun dengan `Column` di dalam `SingleChildScrollView`. Setiap field dibungkus `Padding` dengan `AppSpacing.lg (16)`, dan tombol Save diletakkan di kanan bawah memakai `Align(alignment: Alignment.centerRight)`. Susunan vertikal dipilih karena input form dibaca dan diisi berurutan dari atas ke bawah, dan cocok untuk layar ponsel yang sempit.

`Padding` memberi jarak antar field supaya mudah disentuh, tidak terlihat berdempetan, dan ada ruang untuk pesan error yang muncul di bawah field tanpa menabrak field berikutnya. Saya juga memakai `AppSpacing` sehingga jarak seragam di semua halaman.

`SingleChildScrollView` penting ketika ruang layar terbatas, misalnya layar kecil atau saat papan ketik muncul dan menutupi sebagian layar. Tanpa widget ini, `Column` yang tingginya melebihi layar akan overflow dan field paling bawah atau tombol Save tidak terjangkau. Dengan scroll, pengguna tetap bisa menggulir ke field mana pun dan menekan Save.

### 4. GlobalKey, validator, dan validate()

`GlobalKey<FormState>` dipasang pada widget `Form `agar kita bisa mengakses `FormState` dari luar form, tepatnya dari tombol Save yang berada di dalam `onPressed`. Key ini juga dipakai untuk `reset()` setelah dialog ditutup.

`validator` adalah fungsi pada setiap `TextFormField` yang memeriksa nilai input. Fungsi ini mengembalikan null jika valid, atau string pesan jika tidak valid. Pesan itu ditampilkan di bawah field terkait.

`validate()` dipanggil lewat `_formKey.currentState!.validate()` saat Save ditekan. Fungsi ini menjalankan semua validator dalam form sekaligus, menampilkan pesan error pada field yang gagal, dan mengembalikan true hanya jika semuanya lolos. Dialog ringkasan hanya ditampilkan jika hasilnya true.

Contoh nilai yang ditolak adalah ketika judul skill kosong atau hanya berisi spasi(" "). Validator menolaknya lewat `value.trim().isEmpty`.

Memilih jenis input atau papan ketik saja belum cukup karena keduanya hanya mengatur tampilan dan kemudahan mengisi, bukan aturan pengisian data. Aturan seperti wajib untuk diisi ataupun tidak boleh mengisi field hanya dengan spasi (kosong) hanya bisa dipastikan oleh validator.

## Tugas 8: AI Disclosure

Link: https://claude.ai/share/6056a62c-8e20-4dd4-9a3b-bd5c6fb01c2c

Saya menggunakan Claude AI sebagai alat bantu dalam pengerjaan Tugas 8. Karena form experience mengikuti pola yang sama dengan form skill, bantuan AI lebih banyak dipakai untuk hal yang baru bagi saya, yaitu:

- penggunaan `DateTime`, `showDatePicker()`, dan paket `intl` untuk field tanggal beserta validasi urutan tanggalnya,
- penjelasan alasan di balik suatu kode, seperti perbedaan `border`, `enabledBorder`, dan `focusedBorder`,

Bagian yang saya kerjakan dan sesuaikan sendiri antara lain:

- desain tampilan form (warna tema green untuk skill dan purple untuk experience), termasuk logika agar border berubah warna setelah field terisi, yang saya bangun di atas kerangka `_inputDecoration`
- pemilihan field untuk tiap model (misalnya level skill berupa dropdown dan tanggal selesai yang opsional),
- integrasi navigasi dari kartu dan drawer, serta pengujian alur aplikasi.
