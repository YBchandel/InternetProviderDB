PGDMP     #    $                {            internet_provider    15.3    15.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            
           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    24747    internet_provider    DATABASE     �   CREATE DATABASE internet_provider WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
 !   DROP DATABASE internet_provider;
                postgres    false            �            1255    24932 2   create_admin(character varying, character varying)    FUNCTION     �   CREATE FUNCTION public.create_admin(p_admin_id character varying, p_admin_password character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO admin(admin_id,admin_password)
  VALUES (p_admin_id,p_admin_password);

END;
$$;
 e   DROP FUNCTION public.create_admin(p_admin_id character varying, p_admin_password character varying);
       public          postgres    false            �            1255    41088 �   create_employee(character varying, character varying, character varying, character varying, character varying, character varying, bigint)    FUNCTION     �  CREATE FUNCTION public.create_employee(p_emp_id character varying, p_first_name character varying, p_last_name character varying, p_email character varying, p_department character varying, p_position character varying, p_phone bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO employee(emp_id,first_name,last_name,email,department,position,phone)
  VALUES (p_emp_id, p_first_name,p_last_name,p_email,p_department,p_position, p_phone);

END;
$$;
 �   DROP FUNCTION public.create_employee(p_emp_id character varying, p_first_name character varying, p_last_name character varying, p_email character varying, p_department character varying, p_position character varying, p_phone bigint);
       public          postgres    false            �            1255    41097 "   get_employee_id(character varying)    FUNCTION     �  CREATE FUNCTION public.get_employee_id(p_emp_id character varying) RETURNS TABLE(employee_id character varying, p_first_name character varying, p_last_name character varying, p_status character varying, p_requested_date timestamp without time zone, p_approval_date timestamp without time zone, p_remark character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY SELECT emp_id,first_name,last_name,status,requested_date,approval_date,remark from employee WHERE emp_id = p_emp_id ;
END;
$$;
 B   DROP FUNCTION public.get_employee_id(p_emp_id character varying);
       public          postgres    false            �            1255    32922    get_employees()    FUNCTION     �  CREATE FUNCTION public.get_employees() RETURNS TABLE(id integer, emp_id character varying, first_name character varying, last_name character varying, email character varying, department character varying, p_position character varying, p_status character varying, p_requested_date timestamp without time zone, p_approval_date timestamp without time zone, phone bigint, remark character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY SELECT * FROM employee;
END;
$$;
 &   DROP FUNCTION public.get_employees();
       public          postgres    false            �            1255    41100 *   get_employees_by_status(character varying)    FUNCTION     $  CREATE FUNCTION public.get_employees_by_status(status_value character varying) RETURNS TABLE(id integer, emp_id character varying, first_name character varying, last_name character varying, email character varying, department character varying, p_position character varying, p_status character varying, requested_date timestamp without time zone, approval_date timestamp without time zone, phone bigint, remark character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY  SELECT *
  FROM employee
  WHERE status = status_value;
END;
$$;
 N   DROP FUNCTION public.get_employees_by_status(status_value character varying);
       public          postgres    false            �            1255    41098    is_admin_valid(text, text)    FUNCTION     	  CREATE FUNCTION public.is_admin_valid(p_admin_id text, p_admin_password text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN EXISTS (
SELECT 1
FROM admin
WHERE admin_id = p_admin_id AND admin_password = p_admin_password COLLATE "C"
LIMIT 1
);
END;
$$;
 M   DROP FUNCTION public.is_admin_valid(p_admin_id text, p_admin_password text);
       public          postgres    false            �            1255    41092 E   update_employee_status(integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.update_employee_status(p_id integer, p_status character varying, p_remark character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    updated_id INT;
BEGIN
    UPDATE employee 
    SET status = p_status,
        remark = p_remark,
        approval_date = current_timestamp 
    WHERE id = p_id
    RETURNING id INTO updated_id;

    RETURN updated_id;
END;
$$;
 s   DROP FUNCTION public.update_employee_status(p_id integer, p_status character varying, p_remark character varying);
       public          postgres    false            �            1259    24863    admin    TABLE     v   CREATE TABLE public.admin (
    admin_id character varying NOT NULL,
    admin_password character varying NOT NULL
);
    DROP TABLE public.admin;
       public         heap    postgres    false            �            1259    24877    employee    TABLE     !  CREATE TABLE public.employee (
    id integer NOT NULL,
    emp_id character varying(8) NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    email character varying NOT NULL,
    department character varying NOT NULL,
    "position" character varying NOT NULL,
    status character varying DEFAULT 'Pending'::character varying,
    requested_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    approval_date timestamp without time zone,
    phone bigint,
    remark character varying
);
    DROP TABLE public.employee;
       public         heap    postgres    false            �            1259    24876    employee_id_seq    SEQUENCE     �   CREATE SEQUENCE public.employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.employee_id_seq;
       public          postgres    false    216                       0    0    employee_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.employee_id_seq OWNED BY public.employee.id;
          public          postgres    false    215            p           2604    24880    employee id    DEFAULT     j   ALTER TABLE ONLY public.employee ALTER COLUMN id SET DEFAULT nextval('public.employee_id_seq'::regclass);
 :   ALTER TABLE public.employee ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    216    216                      0    24863    admin 
   TABLE DATA           9   COPY public.admin (admin_id, admin_password) FROM stdin;
    public          postgres    false    214   !                 0    24877    employee 
   TABLE DATA           �   COPY public.employee (id, emp_id, first_name, last_name, email, department, "position", status, requested_date, approval_date, phone, remark) FROM stdin;
    public          postgres    false    216   �!                  0    0    employee_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.employee_id_seq', 66, true);
          public          postgres    false    215            t           2606    24886    employee employee_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.employee DROP CONSTRAINT employee_pkey;
       public            postgres    false    216               D   x��L,��,�MJ(�(�����06��7MOq�H7(�t)�0q)*��1wN��� \1z\\\ ���         �  x�}��n�@������ڝ�c��մ�����T���^^`7y�خ�!���8gf��s�(̻�.�w_����Gb�͊��S�uU4lհ*������Ka޶]�k@����P9�\9�2m/
R�Z3��N!ZD�$F�n�A�����E9�͊��j��U�!��C�"<2���I���`JIk���qk��(�����/����X��$F����zٱǰuӆ�n�&��4�suaE.3��
i��9�n�Dg�޹�߾/��䡆�:�MG�1��MX�^0�4lg��K/4%Ť�΁u�v*��l�!]��.��'W
���/��'_x; {#�v���>�B
_��j7T�p?%�ˤ��\�+�c	�Ƅ��ܸ=m$��@?t��~8��>�>t���m��|._&E��k�N2�!�>D�S�K:����P������hZ��:�(�N�C,����'U	�u5|x�A3��D���n�SyOZ�I2��Y5J�H��"^Y�$e37     