-- -----------------------------------------------------
-- Estructura del proyecto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS bbdd_agendamiento DEFAULT CHARACTER SET utf8 ;
USE bbdd_agendamiento ;

-- -----------------------------------------------------
-- Tabla Roles
-- -----------------------------------------------------
CREATE TABLE roles (
  id_rol INT NOT NULL AUTO_INCREMENT,
  rol_nombre VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_rol)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla Usuarios
-- -----------------------------------------------------
CREATE TABLE usuarios (
  id_rol INT NOT NULL DEFAULT 2,
  id_usuario VARCHAR(100) NOT NULL,
  tipo_doc_usuario VARCHAR(100) NOT NULL,
  doc_usuario INT NOT NULL DEFAULT 0,
  nombres_usuario VARCHAR(100) NOT NULL,
  apellidos_usuario VARCHAR(100) NOT NULL,
  correo_usuario VARCHAR(100) NOT NULL,
  pass_usuario VARCHAR(200) NOT NULL,
  estado_usuario BIT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id_usuario),
  INDEX ind_usuarios_roles (id_rol),
  CONSTRAINT fk_usuarios_roles
    FOREIGN KEY (id_rol)
    REFERENCES roles (id_rol)
    ON DELETE CASCADE
    ON UPDATE CASCADE
  ) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla Empleado
-- -----------------------------------------------------
CREATE TABLE empleados (
  id_empleado VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_empleado),
  INDEX ind_empleados_usuarios (id_empleado),
  CONSTRAINT fk_empleados_usuarios
    FOREIGN KEY (id_empleado)
    REFERENCES usuarios (id_usuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla Clientes
-- -----------------------------------------------------
CREATE TABLE clientes (
  id_cliente VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_cliente),
  INDEX ind_clientes_usuarios (id_cliente),
  CONSTRAINT fk_clientes_usuarios
    FOREIGN KEY (id_cliente)
    REFERENCES usuarios (id_usuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla Citas
-- -----------------------------------------------------
CREATE TABLE citas (
  id_empleado VARCHAR(100) NOT NULL,
  id_cliente VARCHAR(100) NOT NULL,
  id_cita INT NOT NULL,  
  fecha_cita DATE NOT NULL,
  hora_cita TIME not null,  
  PRIMARY KEY (id_cita),
  INDEX ind_citas_empleados (id_empleado),
  INDEX ind_citas_clientes (id_cliente),
  CONSTRAINT `fk_citas_empleados`
    FOREIGN KEY (id_empleado)
    REFERENCES empleados (id_empleado)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_citas_clientes`
    FOREIGN KEY (id_cliente)
    REFERENCES clientes (id_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla Servicios
-- -----------------------------------------------------
CREATE TABLE servicios (
  id_servicio INT NOT NULL AUTO_INCREMENT,
  nombre_servicio VARCHAR(100) NOT NULL,
  descripcion_servicio VARCHAR(300) NOT NULL,
  PRIMARY KEY (id_servicio)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla Lista de Servicios en Citas
-- -----------------------------------------------------
CREATE TABLE lista_servicios (
  id_cita INT NOT NULL,  
  id_servicio INT NOT NULL AUTO_INCREMENT,
  INDEX ind_lista_servicios_citas (id_cita),
  INDEX ind_lista_servicios_servicios (id_servicio),
  CONSTRAINT fk_lista_servicios_citas
    FOREIGN KEY (id_cita)
    REFERENCES citas (id_cita)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_lista_servicios_servicios
    FOREIGN KEY (id_servicio)
    REFERENCES servicios (id_servicio)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;