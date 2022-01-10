[1mdiff --git a/Gemfile.lock b/Gemfile.lock[m
[1mindex e6d47cc..3c59bc7 100644[m
[1m--- a/Gemfile.lock[m
[1m+++ b/Gemfile.lock[m
[36m@@ -292,7 +292,7 @@[m [mDEPENDENCIES[m
   webpacker (~> 5.0)[m
 [m
 RUBY VERSION[m
[31m-   ruby 3.1.0p0[m
[32m+[m[32m   ruby 3.0.3p157[m
 [m
 BUNDLED WITH[m
    2.3.4[m
[1mdiff --git a/config/credentials/development.yml.enc b/config/credentials/development.yml.enc[m
[1mdeleted file mode 100644[m
[1mindex 7f4a4dd..0000000[m
[1m--- a/config/credentials/development.yml.enc[m
[1m+++ /dev/null[m
[36m@@ -1 +0,0 @@[m
[31m-RktQVjF0So0jbTifGiSG2mtgcBMs4V5mXXEF2E/BxBeqbPiG+/34NThy2mPkvI3lOun4iaC3HMhAzGwVrmCgMgKK/u5hWmNWIKbXKrPVF7Nve4fycdcR+hh/JzRxK51ttm0=--NIWYbj3/tyfV34ft--kZXB8EMcynx9kgPWMBmYhQ==[m
\ No newline at end of file[m
[1mdiff --git a/config/credentials/test.yml.enc b/config/credentials/test.yml.enc[m
[1mdeleted file mode 100644[m
[1mindex 4265e6b..0000000[m
[1m--- a/config/credentials/test.yml.enc[m
[1m+++ /dev/null[m
[36m@@ -1 +0,0 @@[m
[31m-oV6mSEDHEStYtIOZ8qLQ6QbVnpRoc79zwFkEkb4GqPEiyKSauyqsfUL7jZ4bhdK94/ZVVui1FUrgnp6kR+HS/9oGkFvorFCO+m8pQ8YTVxc5b4uIos3pgQOLITB7G/bKu2E=--DILlAcEsady9F/y4--TeXiENQUSKIwpU+XO+Ch+w==[m
\ No newline at end of file[m
[1mdiff --git a/config/initializers/lockbox.rb b/config/initializers/lockbox.rb[m
[1mindex 3b13298..f394b49 100644[m
[1m--- a/config/initializers/lockbox.rb[m
[1m+++ b/config/initializers/lockbox.rb[m
[36m@@ -1 +1 @@[m
[31m-Lockbox.master_key = Rails.application.credentials.lockbox[:master_key][m
[32m+[m[32mLockbox.master_key = '0000000000000000000000000'[m
