// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract HackatonTD is ERC721 {
    // Estructura para almacenar los datos
    struct Data {
        string NombreCompleto;
        string Email;
        uint256 DNI;
        string Direccion;
        uint256 AmountUSDT;
        string Hash;
    }

    // Mapping para almacenar los objetos Data con un ID incremental
    mapping(uint256 => Data) private dataMapping;

    // Contador para generar IDs incrementales
    uint256 private currentId;

    // Evento para mostrar el ID asignado al nuevo objeto Data
    event DataAdded(uint256 id);

    constructor() ERC721("HackatonTD", "HTD") {
        currentId = 1; // Inicializa el ID en 1
    }

    // Función para agregar un nuevo objeto Data al mapping
    function addData(
        string calldata _nombreCompleto,
        string calldata _email,
        uint256  _dni,
        string calldata _direccion,
        uint256 _amountUSDT,
        string calldata _hash
    ) external {
        // Crear un nuevo objeto Data
        Data memory newData = Data({
            NombreCompleto: _nombreCompleto,
            Email: _email,
            DNI: _dni,
            Direccion: _direccion,
            AmountUSDT: _amountUSDT,
            Hash: _hash
        });

        // Agregar el objeto al mapping
        dataMapping[currentId] = newData;

        // Mint NFT al remitente con el ID actual
        _mint(msg.sender, currentId);

        // Emitir el evento con el ID asignado
        emit DataAdded(currentId);

        // Incrementar el ID para el próximo objeto
        currentId++;
    }

    // Función para obtener el objeto por ID
    function getData(uint256 _id)
        external
        view
        returns (
            string memory,
            string memory,
            uint256,
            string memory,
            uint256,
            string memory
        )
    {
        // Verificar si el objeto existe en el mapping
        require(
            _id > 0 && _id < currentId,
            "ID no existe en el mapping de datos."
        );

        // Recuperar el objeto del mapping
        Data storage data = dataMapping[_id];

        // Devolver data almacenados en el objeto
        return (
            data.NombreCompleto,
            data.Email,
            data.DNI,
            data.Direccion,
            data.AmountUSDT,
            data.Hash
        );
    }
}
