//
//  Dialogue.swift
//  studySpriteKit
//
//  Created by Vincensa Regina on 14/10/22.
//

import Foundation
import SpriteKit

struct Dialogue {
    var image: String?
    var label: String?
    var name: String? = "Name"
    var riddle: Bool = false
}

enum erry: String {
    case happy = "erry_happy"
    case scared = "erry_scared"
    case normal = "erry_normal"
    case shocked = "erry_shocked"
    
    var value: String {
        return self.rawValue
    }
}

enum leona: String {
    case happy = "leona_happy"
    case scared = "leona_scared"
    case normal = "leona_normal"
    case shocked = "leona_shocked"
    
    var value: String {
        return self.rawValue
    }
}

enum gatekeeper: String {
    case happy = "gatekeeper_happy"
    case sad = "gatekeeper_sad"
    case normal = "gatekeeper_normal"
    
    var value: String {
        return self.rawValue
    }
}

enum senior: String {
    case happy = "senior_happy"
    case shocked = "senior_shocked"
    case normal = "senior_normal"
    case confused = "senior_confused"
    
    var value: String {
        return self.rawValue
    }
}

enum teller: String {
    case happy = "teller_happy"
    case shocked = "teller_shocked"
    case normal = "teller_normal"
    case uncertain = "teller_uncertain"
    
    var value: String {
        return self.rawValue
    }
}

enum nameBox: String {
    case erry = "namebox_erry"
    case leona = "namebox_leona"
    case gk_01 = "namebox_01"
    case gk_02 = "namebox_02"
    case gk_03 = "namebox_03"
    case senior = "namebox_senior"
    case teller = "namebox_teller"
    
    var value: String {
        return self.rawValue
    }
}

let ext_serambi_kanan = [
    Dialogue(image: erry.scared.value, label: "Aduh gawat...", name: nameBox.erry.value),
    Dialogue(image: erry.shocked.value, label: "Aku terlambat di hari pertama bekerja!", name: nameBox.erry.value),
    Dialogue(image: erry.scared.value, label: "Aku harus segera berangkat!", name: nameBox.erry.value)
]

let ext_gate01 = [
    Dialogue(image: gatekeeper.normal.value, label: "Eh, saya tidak pernah melihat kamu disini. Kamu anak baru?", name: nameBox.gk_01.value),
    Dialogue(image: erry.happy.value, label: "Betul pak. Baru hari pertama saya bekerja di divisi sel darah merah!", name: nameBox.erry.value),
    Dialogue(image: gatekeeper.happy.value, label: "Oh! Kalau begitu... SELAMAT DATANG DI KOTA KARDIA!", name: nameBox.gk_01.value),
    Dialogue(image: gatekeeper.happy.value, label: "Kota Kardia adalah jantung yang berfungsi untuk memompa darah ke seluruh tubuh dan menerima darah kembali seusai dari paru-paru.", name: nameBox.gk_01.value),
    Dialogue(image: gatekeeper.happy.value, label: "Saat ini, kamu berada di Serambi Kanan, loh.", name: nameBox.gk_01.value),
    Dialogue(image: erry.shocked.value, label: "Wow, ternyata kota ini keren sekali ya!", name: nameBox.erry.value),
    Dialogue(image: gatekeeper.normal.value, label: "Ya! Jadi, penting sekali untuk menjaga Kota Kardia untuk tetap sehat.", name: nameBox.gk_01.value),
    Dialogue(image: gatekeeper.happy.value, label: "Sekali lagi, selamat datang ya, silahkan masuk.", name: nameBox.gk_01.value),
    Dialogue(image: erry.scared.value, label: "Baik, terima kasih, Pak. Kalau begitu, saya lanjut lagi ya. Saya sudah terlambat!", name: nameBox.erry.value),
    Dialogue(image: gatekeeper.happy.value, label: "Semangat, dik!", name: nameBox.gk_01.value)
]

let int_gate01 = [
    Dialogue(image: leona.shocked.value, label: "Apakah kamu anak baru? Upacara penerimaan karyawan magang baru saja selesai.", name: nameBox.leona.value),
    Dialogue(image: erry.scared.value , label: "Benarkah? Tidak, aku terlambat!", name: nameBox.erry.value),
    Dialogue(image: leona.normal.value, label: "Tenang saja, dari yang saya dengar, upacara tersebut tidak wajib.", name: nameBox.leona.value),
    Dialogue(image: leona.happy.value, label: "Ngomong-ngomong, siapa namamu?", name: nameBox.leona.value),
    Dialogue(image: erry.happy.value, label: "Syukurlah.", name: nameBox.erry.value),
    Dialogue(image: erry.normal.value, label: "Aku Erry, anak magang divisi sel darah merah yang bertugas untuk mengedarkan oksigen keseluruh tubuh dan membawa karbondioksida kembali ke paru-paru. Kalau kamu?", name: nameBox.erry.value),
    Dialogue(image: leona.happy.value, label: "Aku Leona. Kebetulan, hari ini juga hari pertama aku bekerja.", name: nameBox.leona.value),
    Dialogue(image: leona.normal.value, label: "Namun, divisi sel darah putih bertugas untuk patroli dan melawan virus atau bakteri yang masuk ke dalam tubuh.", name: nameBox.leona.value),
    Dialogue(image: erry.happy.value, label: "Wah, halo Leona. Kalau begitu, saya melanjutkan perjalanan ya, sampai jumpa lagi. Senang berkenalan dengan kamu!", name: nameBox.erry.value),
    Dialogue(image: leona.normal.value, label: "Iya, hati-hati selalu ya. Jika bertemu dengan virus dan bakteri, tolong segera beritahu aku atau sel darah putih yang lain, ya.", name: nameBox.leona.value),
    Dialogue(image: leona.happy.value, label: "Sampai jumpa di lain waktu!", name: nameBox.leona.value)
]

let int_guild = [
    Dialogue(image: senior.confused.value, label: "Halo, kamu Erry ya? Di daftar anak baru, hanya kamu saja yang belum absen.", name: nameBox.senior.value),
    Dialogue(image: erry.scared.value, label: "Iya, pak! Maaf, saya terlambat.", name: nameBox.erry.value),
    Dialogue(image: senior.happy.value, label: "Baiklah, jangan diulangi lagi ya.", name: nameBox.senior.value),
    Dialogue(image: senior.normal.value, label: "Nah karena tinggal kamu saja yang belum dapat arahan, sekalian saya jelaskan tugas kamu langsung ya sekarang.", name: nameBox.senior.value),
    Dialogue(image: erry.happy.value, label: "Baik, siap pak!", name: nameBox.erry.value),
    
    Dialogue(image: senior.happy.value, label: "Sistem peredaran darah manusia terbagi menjadi 2, yaitu peredaran darah kecil dan peredaran darah besar. Kamu perlu pahami ini dengan baik...", name: nameBox.senior.value),
    Dialogue(image: senior.confused.value, label: "Peredaran darah kecil dimulai dari jantung ke paru-paru melewati arteri pulmonalis saat membawa karbondioksida,", name: nameBox.senior.value),
    Dialogue(image: senior.normal.value, label: "dan kembali lagi ke jantung melewati vena pulmonalis saat membawa oksigen.", name: nameBox.senior.value),
    Dialogue(image: senior.shocked.value, label: "Sedangkan, peredaran darah besar dimulai dari jantung ke seluruh tubuh melewati aorta (pembuluh arteri terbesar) saat membawa oksigen,", name: nameBox.senior.value),
    Dialogue(image: senior.normal.value, label: "dan kembali ke jantung melewati pembuluh vena saat membawa karbondioksida.", name: nameBox.senior.value),
    Dialogue(image: senior.happy.value, label: "Apakah kamu sudah mengerti?", name: nameBox.senior.value),
    Dialogue(image: erry.scared.value, label: "Siap, saya mengerti, Pak!", name: nameBox.erry.value),
    Dialogue(image: senior.happy.value, label: "Baik, hari ini tugas kamu adalah menuju paru-paru untuk mengambil oksigen. Semoga berhasil!", name: nameBox.senior.value),
]

let int_guild_explanation = [
    Dialogue(image: "", label: "")
]

let int_gate02 = [
    Dialogue(image: gatekeeper.normal.value, label: "Hai anak muda, menjaga gerbang membuatku bosan.", name: nameBox.gk_02.value),
    Dialogue(image: gatekeeper.happy.value, label: "Apakah kamu ingin bermain teka-teki bersamaku?", name: nameBox.gk_02.value),
//    Dialogue(image: gatekeeper.normal.value, label: "'Aku' ada di dalam tubuh manusia, dari kepala sampai kaki. Aku berbentuk cairan. Bisa didonasikan tapi bukan uang, bisa dipompa tapi bukan ban. Siapakah aku?", name: nameBox.gk_02.value),
    Dialogue(image: gatekeeper.normal.value, label: "Setelah bertemu Leona, kamu telah diberi tahu tugas sel darah putih. Apa tugas sel darah putih?", name: nameBox.gk_02.value, riddle: true),
]

let ext_pre_pulmonalis = [
    Dialogue(image: erry.shocked.value, label: "Permisi, pak. Apa itu? kenapa mereka seperti itu?", name: nameBox.erry.value),
    Dialogue(image: gatekeeper.sad.value, label: "Mereka terjebak di dalam tautan benang fibrin dan membentuk gumpalan darah.", name: nameBox.gk_03.value),
    Dialogue(image: gatekeeper.normal.value, label: "Hati-hati, jangan sampai kamu terjebak juga saat melewati Arteri Pulmonalis dan Kapiler, ya!.", name: nameBox.gk_03.value),
    Dialogue(image: erry.happy.value, label: "Terima kasih infonya, pak! Saya akan berhati-hati.", name: nameBox.erry.value),
]

let ext_gate03 = [
    Dialogue(image: erry.happy.value, label: "Halo, pak! Saya harus mengambil oksigen, nih!", name: nameBox.erry.value),
    //Gatekeeper menjelaskan paru2
    Dialogue(image: erry.happy.value, label: "Kalau saya ingin mengambil oksigen, di mana ya tempatnya?", name: nameBox.erry.value),
    Dialogue(image: gatekeeper.happy.value, label: "Oh! Kamu bisa langsung masuk ke ruangan ALVEOLUS!", name: nameBox.gk_03.value),
    Dialogue(image: gatekeeper.normal.value, label: "Teller paru-paru akan menjelaskan semuanya lebih lanjut di sana~", name: nameBox.gk_03.value),
]

let int_alveolus = [
    Dialogue(image: erry.normal.value, label: "Permisi, Saya ditugaskan mengambil oksigen. Apakah benar disini?", name: nameBox.erry.value),
    Dialogue(image: teller.uncertain.value, label: "Iya, benar. Tapi mohon maaf, mesinnya sedang rusak sehingga proses pengambilan oksigen tidak bisa dilakukan sekarang.", name: nameBox.teller.value),
    Dialogue(image: erry.shocked.value, label: "Apakah saya boleh mencoba untuk memperbaikinya?", name: nameBox.erry.value),
    Dialogue(image: teller.happy.value, label: "Wah, terima kasih banyak!", name: nameBox.teller.value),
    Dialogue(image: teller.normal.value, label: "Mesinnya ada di sebelah kiri, ya.", name: nameBox.teller.value),
]

let int_alveolus_puzzle_solved = [
    Dialogue(image: teller.happy.value, label: "Kamu berhasil! Terima kasih, oksigenmu sudah saya masukkan ke dalam tasmu.", name: nameBox.teller.value),
    Dialogue(image: teller.happy.value, label: "Berdasarkan data yang saya terima hari ini, kamu ditugaskan untuk mengantarkan oksigen ke kota tangan. Sampai jumpa lagi.", name: nameBox.teller.value),
    Dialogue(image: erry.happy.value, label: "Baik, terima kasih, Bu!", name: nameBox.erry.value)
]



