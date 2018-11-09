-- MySQL Workbench Synchronization
-- Generated: 2018-10-03 19:06
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Maga

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `proj_int_04`.`produto` (
  `produto_id` INT(11) NOT NULL AUTO_INCREMENT,
  `cor` VARCHAR(50) NOT NULL,
  `tamanho` VARCHAR(50) NOT NULL,
  `SKU` INT(11) NULL DEFAULT NULL,
  `EAN` VARCHAR(45) NULL DEFAULT NULL,
  `preco` DECIMAL(6,2) NULL DEFAULT NULL,
  `estoque` TINYINT(3) NULL DEFAULT NULL,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` VARCHAR(1000) NULL DEFAULT NULL,
  `peso` FLOAT(2) NULL DEFAULT NULL,
  `largura` FLOAT(2) NULL DEFAULT NULL,
  `altura` FLOAT(2) NULL DEFAULT NULL,
  `comprimento` FLOAT(2) NULL DEFAULT NULL,
  `data_validade` DATE NULL DEFAULT NULL,
  `lote_num` VARCHAR(45) NULL DEFAULT NULL,
  `tipo_de_produto` VARCHAR(45) NULL DEFAULT NULL,
  `fornecedor` VARCHAR(45) NULL DEFAULT NULL,
  `fk_categoria_id` INT(11) NOT NULL,
  `item_pedido_id_item_pedido` INT(10) NOT NULL,
  PRIMARY KEY (`produto_id`),
  INDEX `fk_produto_categorias_idx` (`fk_categoria_id` ASC) ,
  INDEX `fk_produto_item_pedido1_idx` (`item_pedido_id_item_pedido` ASC) ,
  CONSTRAINT `fk_produto_categorias`
    FOREIGN KEY (`fk_categoria_id`)
    REFERENCES `proj_int_04`.`categorias` (`categoria_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_item_pedido1`
    FOREIGN KEY (`item_pedido_id_item_pedido`)
    REFERENCES `proj_int_04`.`item_pedido` (`id_item_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `proj_int_04`.`Pedido` (
  `pedido_id` INT(10) NOT NULL,
  `data_pedido` DATE NULL DEFAULT NULL,
  `subtotal` DECIMAL(2) NULL DEFAULT NULL,
  `desconto` DECIMAL(2) NULL DEFAULT NULL,
  `total` DECIMAL(2) NULL DEFAULT NULL,
  `data_entregue` DATE NULL DEFAULT NULL,
  `codigo_de_rastreio` VARCHAR(45) NULL DEFAULT NULL,
  `forma_de_pagamento_id` INT(10) NULL DEFAULT NULL,
  `status_id` INT(10) NULL DEFAULT NULL,
  `status_data` DATE NULL DEFAULT NULL,
  `condicao_de_pagamento` VARCHAR(45) NULL DEFAULT NULL,
  `fk_usuario_id` INT(11) NOT NULL,
  `fk_pagamento_id` INT(10) NOT NULL,
  PRIMARY KEY (`pedido_id`, `fk_pagamento_id`),
  INDEX `fk_Pedido_usuarios1_idx` (`fk_usuario_id` ASC) ,
  INDEX `fk_Pedido_pagamento1_idx` (`fk_pagamento_id` ASC) ,
  CONSTRAINT `fk_Pedido_usuarios1`
    FOREIGN KEY (`fk_usuario_id`)
    REFERENCES `proj_int_04`.`usuarios` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_pagamento1`
    FOREIGN KEY (`fk_pagamento_id`)
    REFERENCES `proj_int_04`.`pagamento` (`pagamento_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `proj_int_04`.`pagamento` (
  `pagamento_id` INT(10) NOT NULL AUTO_INCREMENT,
  `n_parcelas` TINYINT(2) NOT NULL,
  `id_transacao` VARCHAR(20) NOT NULL,
  `horario_transacao` DATETIME NOT NULL,
  `fk_metodo_pagamento_id` INT(11) NOT NULL,
  PRIMARY KEY (`pagamento_id`),
  INDEX `fk_pagamento_metodo_pagamento1_idx` (`fk_metodo_pagamento_id` ASC) ,
  CONSTRAINT `fk_pagamento_metodo_pagamento1`
    FOREIGN KEY (`fk_metodo_pagamento_id`)
    REFERENCES `proj_int_04`.`metodo_pagamento` (`metodo_pagamento_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `proj_int_04`.`cidades` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(40) NULL DEFAULT NULL,
  `ddd` TINYINT(2) NULL DEFAULT NULL,
  `ufs_uf_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cidades_ufs1_idx` (`ufs_uf_id` ASC) ,
  CONSTRAINT `fk_cidades_ufs1`
    FOREIGN KEY (`ufs_uf_id`)
    REFERENCES `proj_int_04`.`ufs` (`uf_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `proj_int_04`.`ufs` (
  `uf_id` INT(11) NOT NULL,
  `nome` VARCHAR(50) NULL DEFAULT NULL,
  `sigla` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`uf_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `proj_int_04`.`categorias` (
  `categoria_id` INT(11) NOT NULL,
  `nome` VARCHAR(50) NULL DEFAULT NULL,
  `descricao` VARCHAR(900) NULL DEFAULT NULL,
  PRIMARY KEY (`categoria_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `proj_int_04`.`endereco` (
  `end_id` INT(11) NOT NULL,
  `cep` INT(11) NULL DEFAULT NULL,
  `bairro` VARCHAR(45) NULL DEFAULT NULL,
  `numero` INT(10) NULL DEFAULT NULL,
  `complemento` INT(10) NULL DEFAULT NULL,
  `endereco_de_entrega` TINYINT(4) NULL DEFAULT NULL,
  `endereco` INT(10) NULL DEFAULT NULL,
  `fk_usuario_id` INT(11) NOT NULL,
  `fk_uf_id` INT(11) NOT NULL,
  `fk_cidades_id` INT(11) NOT NULL,
  PRIMARY KEY (`end_id`),
  INDEX `fk_endereco_usuarios1_idx` (`fk_usuario_id` ASC) ,
  INDEX `fk_endereco_ufs1_idx` (`fk_uf_id` ASC) ,
  INDEX `fk_endereco_cidades1_idx` (`fk_cidades_id` ASC) ,
  CONSTRAINT `fk_endereco_usuarios1`
    FOREIGN KEY (`fk_usuario_id`)
    REFERENCES `proj_int_04`.`usuarios` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_ufs1`
    FOREIGN KEY (`fk_uf_id`)
    REFERENCES `proj_int_04`.`ufs` (`uf_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_cidades1`
    FOREIGN KEY (`fk_cidades_id`)
    REFERENCES `proj_int_04`.`cidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `proj_int_04`.`item_pedido` (
  `id_item_pedido` INT(10) NOT NULL,
  `quantidade` INT(10) NULL DEFAULT NULL,
  `fk_pedido_id` INT(10) NOT NULL,
  PRIMARY KEY (`id_item_pedido`),
  INDEX `fk_item_pedido_Pedido1_idx` (`fk_pedido_id` ASC) ,
  CONSTRAINT `fk_item_pedido_Pedido1`
    FOREIGN KEY (`fk_pedido_id`)
    REFERENCES `proj_int_04`.`Pedido` (`pedido_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `proj_int_04`.`status_pedido` (
  `id_status` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `Pedido_pedido_id` INT(10) NOT NULL,
  `Pedido_fk_pagamento_id` INT(10) NOT NULL,
  PRIMARY KEY (`id_status`),
  INDEX `fk_status_pedido_Pedido1_idx` (`Pedido_pedido_id` ASC, `Pedido_fk_pagamento_id` ASC) ,
  CONSTRAINT `fk_status_pedido_Pedido1`
    FOREIGN KEY (`Pedido_pedido_id` , `Pedido_fk_pagamento_id`)
    REFERENCES `proj_int_04`.`Pedido` (`pedido_id` , `fk_pagamento_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `proj_int_04`.`metodo_pagamento` (
  `metodo_pagamento_id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`metodo_pagamento_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
