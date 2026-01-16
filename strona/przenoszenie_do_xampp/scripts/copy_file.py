import os

site_path = "../../smpiges_site"

class Deployer:
    def __init__(self):
        self.site_path = site_path

    def copy_to_xampp(self, xamp_path):
        for root, dirs, files in os.walk(self.site_path):
            # ścieżka względna względem folderu źródłowego
            sciezka_wzgledna = os.path.relpath(root, self.site_path)
            aktualny_folder_docelowy = os.path.join(xamp_path, sciezka_wzgledna)

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
