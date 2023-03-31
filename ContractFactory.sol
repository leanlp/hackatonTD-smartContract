pragma solidity ^0.8.0;

contract hackatonTD {
    // Estructura para almacenar los strings
    struct StringData {
        string string1;
        string string2;
        string string3;
        string string4;
        string string5;
    }

    // Mapping para almacenar los objetos StringData con un ID incremental
    mapping(uint256 => StringData) private dataMapping;

    // Contador para generar IDs incrementales
    uint256 private currentId;

    // Evento para mostrar el ID asignado al nuevo objeto StringData
    event StringDataAdded(uint256 id);

    constructor() {
        currentId = 1; // Inicializa el ID en 1
    }

    // Función para agregar un nuevo objeto StringData al mapping
    function addStringData(
        string calldata _string1,
        string calldata _string2,
        string calldata _string3,
        string calldata _string4,
        string calldata _string5
    ) external {
        // Crear un nuevo objeto StringData
        StringData memory newData = StringData({
            string1: _string1,
            string2: _string2,
            string3: _string3,
            string4: _string4,
            string5: _string5
        });

        // Agregar el objeto al mapping
        dataMapping[currentId] = newData;

        // Emitir el evento con el ID asignado
        emit StringDataAdded(currentId);

        // Incrementar el ID para el próximo objeto
        currentId++;
    }

    // Función para obtener los strings de un objeto StringData por ID
    function getStringData(uint256 _id)
        external
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        // Verificar si el objeto existe en el mapping
        require(
            _id > 0 && _id < currentId,
            "ID no existe en el mapping de datos."
        );

        // Recuperar el objeto StringData del mapping
        StringData storage data = dataMapping[_id];

        // Devolver los strings almacenados en el objeto
        return (
            data.string1,
            data.string2,
            data.string3,
            data.string4,
            data.string5
        );
    }
}
