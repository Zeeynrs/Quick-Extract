import os
import sys
import tempfile
import unittest
import zipfile
import tarfile
import gzip
import io

from importlib.machinery import SourceFileLoader

bin_path = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "bin", "quick-extract"))
loader = SourceFileLoader("quick_extract", bin_path)
qe = loader.load_module()


class TestQuickExtract(unittest.TestCase):
    def test_base_name_resolution(self):
        self.assertEqual(qe.get_archive_base_name("project.tar.gz"), "project")
        self.assertEqual(qe.get_archive_base_name("backup.tar.bz2"), "backup")
        self.assertEqual(qe.get_archive_base_name("data.tar.xz"), "data")
        self.assertEqual(qe.get_archive_base_name("archive.tar.zst"), "archive")
        self.assertEqual(qe.get_archive_base_name("test.tgz"), "test")
        self.assertEqual(qe.get_archive_base_name("document.zip"), "document")
        self.assertEqual(qe.get_archive_base_name("files.7z"), "files")
        self.assertEqual(qe.get_archive_base_name("test.rar"), "test")
        self.assertEqual(qe.get_archive_base_name("single.txt.gz"), "single.txt")

    def test_single_compressed_detection(self):
        self.assertTrue(qe.is_single_compressed("file.gz"))
        self.assertTrue(qe.is_single_compressed("file.log.bz2"))
        self.assertTrue(qe.is_single_compressed("file.xz"))
        self.assertFalse(qe.is_single_compressed("archive.tar.gz"))
        self.assertFalse(qe.is_single_compressed("archive.tgz"))
        self.assertFalse(qe.is_single_compressed("archive.tar.bz2"))
        self.assertFalse(qe.is_single_compressed("archive.tar.xz"))
        self.assertFalse(qe.is_single_compressed("archive.zip"))

    def test_extract_zip(self):
        with tempfile.TemporaryDirectory() as td:
            zip_path = os.path.join(td, "sample.zip")
            with zipfile.ZipFile(zip_path, "w") as zf:
                zf.writestr("sub/hello.txt", "halo dunia dari zip")

            out_dir = os.path.join(td, "extracted_zip")
            ok, msg = qe.extract_archive(zip_path, out_dir)
            self.assertTrue(ok, msg)
            target_file = os.path.join(out_dir, "sub", "hello.txt")
            self.assertTrue(os.path.exists(target_file))
            with open(target_file, "r") as f:
                self.assertEqual(f.read(), "halo dunia dari zip")

    def test_extract_tar_gz(self):
        with tempfile.TemporaryDirectory() as td:
            tar_path = os.path.join(td, "sample.tar.gz")
            with tarfile.open(tar_path, "w:gz") as tf:
                data = b"konten tar gz"
                ti = tarfile.TarInfo("folder/test.txt")
                ti.size = len(data)
                tf.addfile(ti, io.BytesIO(data))

            out_dir = os.path.join(td, "extracted_tar")
            ok, msg = qe.extract_archive(tar_path, out_dir)
            self.assertTrue(ok, msg)
            target_file = os.path.join(out_dir, "folder", "test.txt")
            self.assertTrue(os.path.exists(target_file))
            with open(target_file, "r") as f:
                self.assertEqual(f.read(), "konten tar gz")

    def test_extract_single_gz(self):
        with tempfile.TemporaryDirectory() as td:
            gz_path = os.path.join(td, "notes.txt.gz")
            with gzip.open(gz_path, "wb") as gf:
                gf.write(b"catatan teks kompresi tunggal")

            out_dir = os.path.join(td, "extracted_gz")
            ok, msg = qe.extract_archive(gz_path, out_dir)
            self.assertTrue(ok, msg)
            target_file = os.path.join(out_dir, "notes.txt")
            self.assertTrue(os.path.exists(target_file))
            with open(target_file, "r") as f:
                self.assertEqual(f.read(), "catatan teks kompresi tunggal")

    def test_zip_slip_security(self):
        with tempfile.TemporaryDirectory() as td:
            zip_path = os.path.join(td, "malicious.zip")
            with zipfile.ZipFile(zip_path, "w") as zf:
                zf.writestr("../../evil.txt", "serangan traversal")

            out_dir = os.path.join(td, "safe_dir")
            # Fallback python check should catch this
            ok, msg = qe.extract_with_python_fallback(zip_path, out_dir)
            self.assertFalse(ok)
            self.assertIn("path traversal", msg.lower())

    def test_cli_subfolder_and_here(self):
        import subprocess
        with tempfile.TemporaryDirectory() as td:
            zpath = os.path.join(td, "myfiles.zip")
            with zipfile.ZipFile(zpath, "w") as zf:
                zf.writestr("test.txt", "data inside zip")

            # Test --subfolder
            res = subprocess.run([bin_path, "--subfolder", "--no-notify", zpath], capture_output=True, text=True)
            self.assertEqual(res.returncode, 0, res.stderr)
            self.assertTrue(os.path.exists(os.path.join(td, "myfiles", "test.txt")))

            # Test --to
            custom_dir = os.path.join(td, "custom_dest")
            res = subprocess.run([bin_path, "--to", custom_dir, "--no-notify", zpath], capture_output=True, text=True)
            self.assertEqual(res.returncode, 0, res.stderr)
            self.assertTrue(os.path.exists(os.path.join(custom_dir, "test.txt")))


if __name__ == "__main__":
    unittest.main()
