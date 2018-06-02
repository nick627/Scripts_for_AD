Microsoft Windows Server 2008 R2 SP1 - Оригинальные образы с MSDN [Русский+Английский] (Retail+VL):
   https://rutracker.org/forum/viewtopic.php?t=3512678

Windows Server 2012 R2:
   http://rutracker.ucoz.org/load/windows/windows_server_2012_r2_with_update_x64_originalnye_obrazy_ot_microsoft_msdn_ru/2-1-0-209
      Code activate: D2N9P-3P6X9-2R39C-7RTCD-MDVJX

// скачали ru_windows_server_2008_r2_standard_enterprise_datacenter_and_web_with_sp1_x64_dvd_617389.iso или > 2008 R2
Скачивайте лучше АНГЛИЙСКИЕ сервер (>= 12) и виртуалку

Установили Standart с графической оболчкой (полная установка) (иначе будет одна командая строка)

Демонтируйте диск, с которого устанавливали, не трогайте настройки интернета
Сделайте так чтобы сервер и машины пинговались (самое лучшее VMWare):
 VirtualBox->Файл->Настроить->Сеть->Добавить новую сеть NAT
 На машинах в настройках->Сеть->Сеть NAT (Тип адаптера Intel PRO/1000 MT Server для сервера и Intel PRO/1000 MT Desktop для обычной винды)

// проверьте чтобы сервер пинговал основную машину и наоборот, если нет, то сделайте чтобы пинговались
// если хост пингует виртуалку, а в обратную сторону нет, отключите FireWall (Брандмауэр Windows) на хосте

Для установки Active Directory (AD) cледуем тому, что написано:
   http://hutpu4.net/puplication/osnovy-raboty-s-active-directory-chast-pervaya-ustanovka-i-nastrojka-komponentov.html

После установки добавьте новую роль: файловые службы (для общей папки, файлового сервера)

Для запуска скриптов из PowerShell:
   http://get-powershell.ru/2014/zapusk-skripta-powershell/
А именно - запустить PowerShell:
   Для разрешения запуска скриптов из PowerShell
   PS C:\Users\Administrator> Set-ExecutionPolicy RemoteSigned

   Для разрешения запуска скриптов PowerShell с удаленных машин
      Set-ExecutionPolicy RemoteSigned

   Скрипты запускаются следующим образом:
      PS C:\Users\Administrator> .\test.ps1
    или
      PS C:\Users\powershell> C:\Users\Administrator\test.ps1

Создать подраздедения: 1_create_new_OrganizationUnit.ps1
 Удалить подразделение:
  Вид->Дополнительно, Свойства подразделения->Объект->Не защищить объект от случайного удаления

Создать группы: 2_create_new_group.ps1

Настроить полномочия для созданных групп- Account Managers, Help Desk, Resource Admins, Genereal Admins:
   https://www.howtogeek.com/50166/using-the-delegation-of-control-wizard-to-assign-permissions-in-server-2008/
  или
   скрипт 3_rules_for_manager.bat

Для папок компьютера:
   script.bat закиньте на серваке в C:\Windows\SYSVOL\sysvol\%DomainName%\scripts
   // script.bat будет запускаться каждый раз перед входом пользователя

Добавить/удалить тестовых пользователей: 4_add_delete_user.ps1

Поиск заблокированных пользователей (в подразделении Students): 5_unlock_users.ps1 Students

Поиск пользователей, у которых скоро истекает срок действия пароля (меньше, чем 90 дней): 6_search_users.ps1 90


Подключение строннего компьютера к домену:
   Центр упрвления сетями и общим доступом->Изменение параметров адаптера->Настройка TCP/IPv4->Использовать следующие адреса DNS-серверов->IP сервера
   
   Компьютер->Свойства->Изменить параметры->Имя компьютера->Изменить->Является членом Домена->DomeName.com->OK->Ввести данные учетной записи->Перезагрузить компьютер


Пуск
 Все программы
  Администрирование
   Управление групповой политикой
    Лес
     Домены
      DomenName
       Domain Contolers
        Default Domain Contolers Policy: Right Button->Edit

Чтобы пользователи могли зайти на сервер:
https://www.youtube.com/watch?v=WNPKvyF3ezs
         Конфигурация компьютера
          Политики
           Конфигурация Windows
            Параметры безопасности
             Локальные политики 
              Назначение прав пользователей
               Локальный вход в систему: Добавить нужные группы и пользователей (проще Everyone/Все)

         cmd->gpupdate
         // обнавление политики


Пуск
 Все программы
  Администрирование
   Управление групповой политикой
    Лес
     Домены
      DomenName
       Default Domain Policy: Right Button->Edit

Для блокировки пользователся после неправлильных попыток ввода пароля (3)
        Политика Default Domain Policy
         Конфигурация компьютера
          Политики
           Конфигурация Windows
            Параметры безопасности
             Политики учетных записей
              Политики блокировки учетных записей: 
               Пороговое знанчение блокировки 	= 3
               Время блокировки 				= 5 мин

Для создания сетевого диска
        Политика Default Domain Policy
         Конфигурация пользователя
          Настройка
           Конфигурация Windows
            Сопоставления дисков: Right Button->Create->Сопоставленый диск
             Создать
             Размещение (example, \\WIN-MNR9E21V880\SharedFolder\%UserName%)
             Буква диска
             Показать диск, показать все диски

        cmd->gpupdate
        // обнавление политики


Может будут полезны:
https://www.youtube.com/watch?v=1schSDNx-1E
https://www.youtube.com/watch?v=kRodsmjVDkE

Не уверен, что 3_rules_for_manager.bat делегирует права правильно (accountmanagers не могу создать поьльзователей, helpdesk разблочить юзеров (возможно из-за того, что хотел разблочить юзера в другой папке)), поэтому используйте Adil/rules_fix.bat
