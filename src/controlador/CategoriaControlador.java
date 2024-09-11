/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import conexion.Database;
import modelo.Categoria;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CategoriaControlador {

    // Método para registrar una nueva categoria
    public boolean registrarCategoria(Categoria categoria) {
    Connection connection = Database.getConnection();
    boolean registrado = false;

    if (connection != null) {
        try {
            String query = "INSERT INTO Categorias (nombre_categoria, descripcion) VALUES (?, ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, categoria.getNombre());
            statement.setString(2, categoria.getDescripcion());

            registrado = statement.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al registrar categoria: " + e.getMessage());
        } finally {
            Database.closeConnection(connection);
        }
    }

    return registrado;
}

    // Método para obtener todas las categorias
    public ArrayList<Categoria> obtenerCategorias() {
        ArrayList<Categoria> categorias = new ArrayList<>();
        Connection connection = Database.getConnection();

        if (connection != null) {
            try {
                String query = "SELECT * FROM Categorias";
                PreparedStatement statement = connection.prepareStatement(query);
                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    Categoria cate = new Categoria();
                    cate.setIdCategoria(resultSet.getInt("id_categoria"));
                    cate.setNombre(resultSet.getString("nombre_categoria"));
                    cate.setDescripcion(resultSet.getString("descripcion"));
                    categorias.add(cate);
                }

            } catch (SQLException e) {
                System.out.println("Error al obtener categorias: " + e.getMessage());
            } finally {
                Database.closeConnection(connection);
            }
        }

        return categorias;
    }

    // Método para actualizar una categoria
    public boolean actualizarCategoria(Categoria categoria) {
    Connection connection = Database.getConnection();
    boolean actualizado = false;

    if (connection != null) {
        try {
            // Corregido: cambiar "Carrera" a "nombre_carrera"
            String query = "UPDATE Categorias SET nombre_categoria = ?, descripcion = ? WHERE id_categoria = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, categoria.getNombre());
            statement.setString(2, categoria.getDescripcion());
            statement.setInt(3, categoria.getIdCategoria());

            actualizado = statement.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al actualizar categoria: " + e.getMessage());
        } finally {
            Database.closeConnection(connection);
        }
    }

    return actualizado;
}

    // Método para eliminar una categoria
    public boolean eliminarCategoria(int idCategoria) {
        Connection connection = Database.getConnection();
        boolean eliminado = false;

        if (connection != null) {
            try {
                String query = "DELETE FROM Categorias WHERE id_categoria = ?";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setInt(1, idCategoria);

                eliminado = statement.executeUpdate() > 0;

            } catch (SQLException e) {
                System.out.println("Error al eliminar categoria: " + e.getMessage());
            } finally {
                Database.closeConnection(connection);
            }
        }

        return eliminado;
    }
}

