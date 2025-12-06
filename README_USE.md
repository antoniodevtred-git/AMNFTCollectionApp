📘 README (ESPAÑOL)
✅ Objetivo

DApp/contrato para mintear NFTs (mint-only). Cada token necesita su URI de metadatos y las imágenes se alojan en IPFS.

1) Crear URIs “metadatos” (IPFS)

Tus pasos:

Cada token necesita su uri.

Crear archivo.json ej: 0.json, añadir los metadatos necesarios.

Imagen se subirá a IPFS (https://app.pinata.cloud/ipfs
), donde rellenaremos el campo image con esta url -> (campo CID).

Cuando rellenen todos archivos.json, se subirá la carpeta entera a IPFS la cual será el URI (link del SmartContract).

Ejemplo de 0.json:

{
  "name": "BANFT #0",
  "description": "Colección BANFT",
  "image": "ipfs://<CID_DE_IMAGENES>/0.png",
  "attributes": [
    { "trait_type": "Rarity", "value": "Common" }
  ],
  "external_url": "https://tusitio.com"
}


Corrección sugerida (importante):

El baseUri del contrato debe apuntar al CID de la carpeta de metadatos y terminar en /.
Ej.: ipfs://<CID_DE_METADATA>/ → así el contrato formará ipfs://<CID>/0.json.

2) Comprobar SmartContract desplegado

Tus pasos:

Crear cuenta en arbiscan, coger nuestra private key y añadirla al .env ETHERSCAN_API_KEY.

Corrección sugerida:

En Arbiscan, lo que necesitas es la API Key de Arbiscan (no tu private key).

.env → ETHERSCAN_API_KEY=TU_API_KEY_DE_ARBISCAN

Tu private key (de MetaMask) va en PRIVATE_KEY para firmar el deploy (NUNCA publiques esa clave).

3) Deployar NFTs en Arbitrum

Tus pasos:

Crear archivo .env en el directorio principal donde crearemos la variable PRIVATE_KEY de tu cartera de MetaMask.

El archivo .env no se subirá a git ya que tiene datos sensibles.

Para deployar el SC necesitamos saber qué red, como ejemplo ARBITRUM (por el coste de gas).

Comando:

forge script /AMNftClaimApp/test/AMNFTCollection.t.sol --rpc-url "URL arbitrun elegida en ChainList elegir un buen RPC para evitar fallos" -broadcast --verify


Corrección sugerida (muy importante):

No ejecutes un test (.t.sol en test/) como script. Debe ser un script (.s.sol) dentro de script/.

Usa variables de entorno y placeholders claros:

Ejemplo de .env:

PRIVATE_KEY=0xTU_PRIVATE_KEY      # NUNCA publiques esto
RPC_URL=https://...               # De ChainList (Arbitrum / Arbitrum Sepolia)
ETHERSCAN_API_KEY=TU_ARBISCAN_KEY


Comando recomendado (Arbitrum Sepolia o Arbitrum One):

forge script script/TU_SCRIPT.s.sol:NombreDelContrato \
  --rpc-url $RPC_URL \
  --broadcast --verify \
  --etherscan-api-key $ETHERSCAN_API_KEY

📙 README (ENGLISH)
✅ Goal

Mint-only ERC721. Each token needs its metadata URI; images and metadata are hosted on IPFS.

1) Create metadata URIs (IPFS)

Your steps:

Each token needs its URI.

Create file.json e.g., 0.json and add required metadata.

Upload images to IPFS (https://app.pinata.cloud/ipfs
) and set the image field with this CID URL.

Once all .json files are ready, upload the entire folder to IPFS — this folder CID will be the base URI in the Smart Contract.

Example 0.json:

{
  "name": "BANFT #0",
  "description": "BANFT collection",
  "image": "ipfs://<IMAGES_CID>/0.png",
  "attributes": [
    { "trait_type": "Rarity", "value": "Common" }
  ],
  "external_url": "https://your-site.com"
}


Suggested fix (important):

Contract baseUri must point to the METADATA folder CID and end with /.
Example: ipfs://<METADATA_CID>/ → contract builds ipfs://<CID>/0.json.

2) Check deployed SmartContract

Your steps:

Create an account on Arbiscan, take our private key and add it to .env ETHERSCAN_API_KEY.

Suggested fix:

For Arbiscan verification you need the Arbiscan API Key, not your private key.

.env → ETHERSCAN_API_KEY=YOUR_ARBISCAN_API_KEY

Your private key is for deployment signing and goes to PRIVATE_KEY.

3) Deploy NFTs on Arbitrum

Your steps:

Create a .env with PRIVATE_KEY (MetaMask).

Do not commit .env to git (sensitive data).

Choose the network (e.g., ARBITRUM for cheaper gas).

Command:

forge script /AMNftClaimApp/test/AMNFTCollection.t.sol --rpc-url "Arbitrum RPC from ChainList" -broadcast --verify


Suggested fix (critical):

Do not run a test (.t.sol) as a script. Use a script (.s.sol) inside script/.

Sample .env:

PRIVATE_KEY=0xYOUR_PRIVATE_KEY
RPC_URL=https://...           # from ChainList
ETHERSCAN_API_KEY=YOUR_ARBISCAN_KEY


Recommended command (Arbitrum Sepolia / One):

forge script script/YOUR_SCRIPT.s.sol:ContractName \
  --rpc-url $RPC_URL \
  --broadcast --verify \
  --etherscan-api-key $ETHERSCAN_API_KEY