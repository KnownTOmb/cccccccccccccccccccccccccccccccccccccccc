import os
import shutil

site_path = "../smipegs_site"

class Deployer:
    def __init__(self):
        self.site_path = site_path

    def copy_to_xampp(self, xamp_path):
        # Pobieramy nazwę głównego folderu
        folder_name = os.path.basename(self.site_path.rstrip('/\\'))
        docelowa_sciezka = os.path.join(xamp_path, folder_name)
        
        # Jeśli folder docelowy istnieje, usuń go (sync)
        if os.path.exists(docelowa_sciezka):
            shutil.rmtree(docelowa_sciezka)
            print(f"Usunięto stary folder: {docelowa_sciezka}")
        
        for root, dirs, files in os.walk(self.site_path):
            # ścieżka względna względem folderu źródłowego
            sciezka_wzgledna = os.path.relpath(root, self.site_path)
            
            # jeśli to główny folder, nie dodajemy do ścieżki
            if sciezka_wzgledna == ".":
                aktualny_folder_docelowy = docelowa_sciezka
            else:
                aktualny_folder_docelowy = os.path.join(docelowa_sciezka, sciezka_wzgledna)

            # tworzymy folder docelowy, jeśli nie istnieje
            os.makedirs(aktualny_folder_docelowy, exist_ok=True)

            for plik in files:
                src = os.path.join(root, plik)
                dst = os.path.join(aktualny_folder_docelowy, plik)

                self._copy_file(src, dst)
                print(f"Nadpisano: {dst}")

    def _copy_file(self, src, dst):
        with open(src, "rb") as f_src:
            with open(dst, "wb") as f_dst:
                while True:
                    chunk = f_src.read(1024 * 1024)  # 1 MB
                    if not chunk:
                        break
                    f_dst.write(chunk)
