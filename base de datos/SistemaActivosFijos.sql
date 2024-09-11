-- Crear la base de datos
CREATE DATABASE SistemaActivosFijos;
USE SistemaActivosFijos;

-- Tabla Usuarios
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol ENUM('administrador', 'usuario') NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Usuarios (nombre, email, password, rol) VALUES
('limberth', 'limberth@gmail.com', 'limberth12', 'administrador'),
('ariel', 'ariel@example.com', 'ariel12', 'usuario');

INSERT INTO Usuarios (nombre, email, password, rol) VALUES
('admin', '1', '1', 'administrador');
-- Tabla Carreras
CREATE TABLE Carreras (
    id_carrera INT AUTO_INCREMENT PRIMARY KEY,
    nombre_carrera VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- Tabla Departamentos
CREATE TABLE Aulas (
    id_aula INT AUTO_INCREMENT PRIMARY KEY,
    nombre_aula VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL,
	descripcion varchar(255) NOT NULL
);
select * from Categorias;
-- Tabla Activos
CREATE TABLE Activos (
    id_activo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_activo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    codigo_activo VARCHAR(50) NOT NULL UNIQUE,
    fecha_adquisicion DATE NOT NULL,
    cantida INT NOT NULL,
    costo_unitario DECIMAL(10, 2) NOT NULL,
    costo_total DECIMAL(10,2) NOT NULL,
    valor_actual DECIMAL(10, 2),
    vida_util INT NOT NULL, -- en años
    id_carrera INT,
    id_aula INT,
    id_categoria INT,
    estado ENUM('operativo', 'en_mantenimiento', 'dado_de_baja') DEFAULT 'operativo',
    FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera),
    FOREIGN KEY (id_aula) REFERENCES Aulas(id_aula),
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

-- Tabla Mantenimiento
CREATE TABLE Mantenimiento (
    id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_activo INT NOT NULL,
    fecha_mantenimiento DATE NOT NULL,
    tipo_mantenimiento ENUM('preventivo', 'correctivo') NOT NULL,
    descripcion TEXT,
    costo DECIMAL(10, 2),
    realizado_por VARCHAR(100),
    FOREIGN KEY (id_activo) REFERENCES Activos(id_activo)
);
ALTER TABLE Mantenimiento 
ADD CONSTRAINT mantenimiento_ibfk_1 
FOREIGN KEY (id_activo) REFERENCES Activos(id_activo) 
ON DELETE CASCADE;

ALTER TABLE Mantenimiento DROP FOREIGN KEY mantenimiento_ibfk_1;

-- Tabla Transferencias
CREATE TABLE Transferencias (
    id_transferencia INT AUTO_INCREMENT PRIMARY KEY,
    id_codigo VARCHAR(50) NOT NULL,
    fecha_transferencia DATE NOT NULL,
    id_carrera_origen INT,
    id_aula_origen INT,
    id_carrera_destino INT,
    id_aula_destino INT,
    motivo TEXT,
    FOREIGN KEY (id_carrera_origen) REFERENCES Carreras(id_carrera),
    FOREIGN KEY (id_aula_origen) REFERENCES Aulas(id_aula),
    FOREIGN KEY (id_carrera_destino) REFERENCES Carreras(id_carrera),
    FOREIGN KEY (id_aula_destino) REFERENCES Aulas(id_aula)
);

-- Tabla Depreciacion
CREATE TABLE Depreciacion (
    id_depreciacion INT AUTO_INCREMENT PRIMARY KEY,
    id_activo INT NOT NULL,
    codigo_activo VARCHAR(50) NOT NULL,
    fecha_calculo DATE NOT NULL,
    valor_original DECIMAL(10, 2) NOT NULL, 
    valor_depreciado DECIMAL(10, 2) NOT NULL,
    valor_actual DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_activo) REFERENCES Activos(id_activo),
    FOREIGN KEY (codigo_activo) REFERENCES Activos(codigo_activo)
);


