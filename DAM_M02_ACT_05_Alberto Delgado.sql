
create tablespace academia datafile 'C:\oraclexe\app\oracle\oradata\XE\academia.dbf' size 400M:
create user world identified by "1234" default tablespace academia;
grant all privileges to world;
SELECT privilege FROM dba_sys_privs WHERE grantee='WORLD';

connect world;





create table curso ( codigo char(3) primary key, nombre varchar2(30) not null, horario varchar2(11),
fecha_inicio date,fecha_fin date,precio number(3),profesor varchar2(20) );
insert into curso values ('db1','Bases de Datos 1','09:00-09:45','15-sep-20','15-dic-20','450','Luis M.');
insert into curso values ('db2','Bases de Datos 2','12:00-12:45','15-sep-20','15-dic-20','550','Luis M.');
insert into curso values ('lin','SO Linux','09:00-09:45','15-sep-20','15-dic-20','250','Manuel D.');
insert into curso values ('win','SO Windows','10:15-11:00','15-sep-20','15-dic-20','450','Manuel D.');
insert into curso values ('fol','Formacion Laboral','12:00-12:45','15-sep-20','15-dic-20','350','Juana R.');
insert into curso values ('pr1','Programacion 1','09:00-09:45','15-sep-20','15-dic-20','450','Arancha J.');
insert into curso values ('pr2','Programacion 2','11:00-11:45','15-sep-20','15-dic-20','450','Arancha J.');

create table alumno ( id number primary key, nombre varchar2(30) not null, curso char(3) not null,
fecha_inscrip date, constraint fk_cur_alu foreign key (curso) references curso(codigo) );
insert into alumno values('1','Juan Perez','db2','11-ago-2020');
insert into alumno values('2','Rodrigo de Juan','fol','15-jul-2020');
insert into alumno values('3','Pedro Sierra','db2','11-ago-2020');
insert into alumno values('4','Maria Cobo','db1','11-ago-2020');
insert into alumno values('5','Alejandro Ruiz','db1','17-ago-2020');
insert into alumno values('6','Susana Pelaez','win','01-ago-2020');
insert into alumno values('7','Laura Serna','db2','21-jul-2020');
insert into alumno values('8','Javier Latas','lin','02-jul-2020');
insert into alumno values('9','Juan Casilla','pr2','14-jun-2020');
insert into alumno values('10','Ainhoa Silla','pr1','17-jun-2020');

create user secre1 identified by "world1234" DEFAULT TABLESPACE academia;
create user secre2 identified by "world1234" DEFAULT TABLESPACE academia;

grant create session to secre1;
grant select, insert, update, delete on curso to secre1, secre2;
grant select, insert, update, delete on alumno to secre1, secre2;
SELECT substr(privilege,1,25) as privilegio, substr(table_name,1,25) as tabla FROM dba_tab_privs WHERE grantee=’SECRE1’;
SELECT substr(privilege,1,25) as privilegio, substr(table_name,1,25) as tabla FROM dba_tab_privs WHERE grantee=’SECRE2’;


create profile perfilprofe limit connect_time 60  sessions_per_user 2 password_life_time 30;
alter user profe1 profile perfilprofe;

SELECT resource_name, substr(limit,1,20) FROM DBA_PROFILES WHERE profile='profe1';

-- perfiles
-- Crear un perfil llamado perfil1 que limite las sesiones concurrentes por usuario a 2,
-- el tiempo de conexión a 10 minutos, el cambio de contraseña a 30 dias y 3 intentos de inicio de sesión.
CREATE PROFILE perfil1 LIMIT
SESSIONS_PER_USER 2
CONNECT_TIME 10
PASSWORD_LIFE_TIME 30
FAILED_LOGIN_ATTEMPTS 3;

-- Asignar el perfil1 al user2.
ALTER USER user2 PROFILE perfil1;

-- Modificamos el límite de cambio de 
-- contraseña del perfil1 a 15 días.
ALTER PROFILE perfil1 LIMIT
PASSWORD_LIFE_TIME 15;

-- Listar los límites del perfil1.

SELECT resource_name, substr(limit,1,20) FROM DBA_PROFILES WHERE profile='PERFIL1';
