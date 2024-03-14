# Blob Storage

Blob storage is a type of data storage designed for storing large amounts of unstructured data, such as text or binary data. It stands for "Binary Large Object" storage and is optimized for storing massive amounts of data, including documents, images, videos, and audio files.

# Blob Storage vs. Hierarchical File Storage

## Blob Storage
- **Structure**: Flat, with blobs stored in containers. Each blob is identified by a unique URL.
- **Data Type**: Optimized for large amounts of unstructured data, such as videos, images, and documents.
- **Use Cases**: Ideal for web-based applications, streaming content, and storing large data objects that don't require a file system's organization.
- **Scalability**: Highly scalable, often used in cloud storage solutions where vast amounts of data need to be stored and accessed globally.
- **Access**: Access is typically through RESTful APIs or SDKs, making it flexible for various programming environments.

## Hierarchical File Storage
- **Structure**: Organized in a directory tree structure, with files stored in folders, and folders within folders.
- **Data Type**: Suitable for structured and unstructured data, with an emphasis on files that benefit from a hierarchical organization, such as documents, spreadsheets, and system files.
- **Use Cases**: Common in traditional file systems like those in operating systems (Windows, macOS, Linux).
- **Scalability**: Can become challenging to manage and navigate as the volume of files and directories grows significantly.
- **Access**: Access is typically through file system APIs, and users can interact with the storage using standard file operations like open, read, write, and close.

In summary, blob storage is best for large-scale unstructured data requiring global access and scalability, while hierarchical file storage is suited for applications that benefit from a structured directory approach.

## Advantages of Blob Storage

1. **Scalability**: Easily scales to accommodate massive amounts of data, making it ideal for cloud storage needs.
2. **Accessibility**: Data stored in blob storage can be accessed from anywhere via HTTP/HTTPS, facilitating integration with web services and applications.
3. **Cost-Effectiveness**: Often more cost-effective for storing large amounts of unstructured data, especially with tiered storage options.
4. **Durability and Availability**: Designed for high durability, availability, and redundancy, ensuring data is protected against failures.

## Disadvantages of Blob Storage

1. **Complexity**: Accessing and managing blob storage can be more complex than traditional file systems, requiring additional tools or SDKs.
2. **Latency**: Can experience higher latency than local or hierarchical file storage systems, especially if data is frequently accessed.
3. **Data Consistency**: Immediate consistency is not always guaranteed, which can be a concern for some applications requiring real-time data updates.
4. **Security Concerns**: Data is accessed over the internet, necessitating robust security measures to prevent unauthorized access.

## Tiers

Hot, Cool, Cold, and Archive

https://azure.microsoft.com/en-gb/pricing/calculator/

# Azure Blob Storage Components

Azure Blob Storage is structured into several key components that organize and manage data. The hierarchy from the broadest to the most specific is: Storage Account, Container, and Blobs. Here's how they relate to each other:

## Storage Account

- The **Storage Account** provides a unique namespace in Azure for your data. Think of it as the top-level component under which you can create one or more containers. It's where you set up credentials, access controls, and choose the geographic location where your data will reside. Each account can contain an unlimited number of containers, and it's the level at which billing is aggregated.

## Container

- A **Container** acts like a directory within your Storage Account. It's used to group a set of blobs together, much like a folder in a traditional file system. All blobs reside within a container, and you can have as many containers as you need within a storage account. Containers help organize your data and can also have their own set of permissions, making it easier to manage access to blobs grouped together.

## Blobs

- **Blobs** are the individual files that you store in Azure Blob Storage. There are three types of blobs:
    - **Block Blobs**: Ideal for text or binary data, such as documents, media files, and backups.
    - **Append Blobs**: Designed for append operations, such as logging and data collection.
    - **Page Blobs**: Suitable for frequent read/write operations, such as VHD files used by Azure Virtual Machines.

## Relationship

- The relationship can be visualized as a tree: At the root, you have the **Storage Account**, which can contain multiple **Containers** (like branches), and each Container can hold numerous **Blobs** (like leaves). This structure allows for efficient organization, management, and access to large volumes of unstructured data.

# Types of Redundancy in Azure Block Blob Storage

Azure Block Blob Storage offers various redundancy options to ensure data durability and high availability. Each redundancy option is designed to meet different requirements for availability, durability, and cost.

![Redundancy Options](imgs/redundancy.png "Redundancy Options")

## Locally Redundant Storage (LRS)

- **LRS** replicates your data three times within a single data center in the same region. It protects your data from normal hardware failures but not from the failure of a data center.

## Zone-Redundant Storage (ZRS)

- **ZRS** replicates your data across three Azure availability zones in the same region, protecting against data center-level failures. This offers higher availability and durability than LRS.

## Geo-Redundant Storage (GRS)

- **GRS** is an extension of LRS and replicates your data to a secondary region hundreds of miles away from the primary region. It provides six copies of your data: three in the primary region and three in the secondary region. GRS is designed for scenarios where recovery is required after a regional outage.

## Read-Access Geo-Redundant Storage (RA-GRS)

- **RA-GRS** builds upon GRS by providing read-only access to the data in the secondary region. This option is useful when you need to access your data even during a regional outage or for load balancing read access across regions.

## Geo-Zone-Redundant Storage (GZRS)

- **GZRS** combines the features of ZRS and GRS, replicating data across availability zones in the primary region and then to another region. This provides a high level of durability and availability, protecting against both data center and regional outages.

## Read-Access Geo-Zone-Redundant Storage (RA-GZRS)

- **RA-GZRS** is the most robust redundancy option, extending GZRS by offering read-only access to data in the secondary region. This maximizes availability and durability, ensuring access to your data even if the primary region is completely unavailable.

## Key Differences

- **Availability and Durability**: Higher redundancy options (like GZRS and RA-GZRS) offer increased data availability and durability, protecting against more significant outages.
- **Cost**: As redundancy increases, so does the cost. LRS is the most cost-effective but offers the least protection, while options like RA-GZRS are more expensive but provide the highest level of data protection.
- **Access**: RA-GRS and RA-GZRS allow read-only access to data in the secondary region, useful for high-availability scenarios.

Choosing the right redundancy option depends on your application's requirements for availability, durability, and budget. For critical data requiring high availability and durability, GZRS or RA-GZRS are recommended, while LRS or ZRS might suffice for less critical data.


# Cost Differences in Azure Blob Storage Redundancy Options

Azure Blob Storage offers different redundancy options, each with varying levels of data protection and associated costs. The cost implications are influenced by the level of redundancy, data replication, and geographic distribution. Here's a general overview of how costs can differ among the options:

## Locally Redundant Storage (LRS)

- **LRS** is the most cost-effective option since it replicates data within a single storage scale unit in a data center. It incurs the least cost because it does not provide geo-replication.

## Zone-Redundant Storage (ZRS)

- **ZRS** costs more than LRS because it replicates data across three availability zones within the same region, increasing durability and availability but also operational costs.

## Geo-Redundant Storage (GRS)

- **GRS** incurs higher costs than LRS and ZRS due to geo-replication of data to a secondary region, which doubles the amount of stored data and adds complexity in managing cross-regional replication.

## Read-Access Geo-Redundant Storage (RA-GRS)

- **RA-GRS** is more expensive than GRS as it provides read-access to the replicated data in the secondary region, adding costs related to data access and transfer on top of the replication costs.

## Geo-Zone-Redundant Storage (GZRS)

- **GZRS** combines the costs of ZRS and GRS, making it more expensive due to both zone and geo-replication, offering high levels of durability and availability.

## Read-Access Geo-Zone-Redundant Storage (RA-GZRS)

- **RA-GZRS** is the most expensive option, combining the costs associated with GZRS and providing read-access in the secondary region, further increasing the costs due to additional read-access capabilities.

## Key Cost Factors

- **Replication**: More copies of data mean higher storage costs.
- **Data Transfer**: Accessing data across regions can incur data transfer costs, especially with RA-GRS and RA-GZRS.
- **Operational Complexity**: Managing data across multiple zones and regions adds to the cost due to increased operational complexity.

It's important to note that Azure's pricing can vary by region, and specific pricing details should be checked on the Azure Pricing Calculator or directly with Azure support for the most accurate and up-to-date information.

Choosing the right redundancy option involves balancing the need for data durability and availability with cost considerations, depending on the specific requirements of your application or workload.

## compare options available on Azure Pricing Calculator at region UK South compared to UK West - why the differences?

# Selecting Redundancy Type for Azure Blob Storage

Follow these steps to select or change the redundancy type for your Azure Blob Storage through the Azure Portal:

## Creating a New Storage Account with Desired Redundancy

1. **Navigate to Storage Accounts**

2. **Create a New Storage Account**

3. **Fill in the Basics**: In the "Basics" tab, select your Subscription, Resource Group, Storage Account Name, and the Region where you want your storage to be located.

4. **Select the Performance and Redundancy**:
    - Under "Performance", choose between "Standard" and "Premium", depending on your needs.
    - For "Redundancy", select your desired redundancy option from the dropdown menu (LRS, GRS, ZRS, RA-GRS, GZRS, or RA-GZRS).

5. **Review and Create**

## Modifying Redundancy Type of an Existing Storage Account

It's important to note that not all redundancy changes are supported post-creation, and some changes might involve data movement, potentially incurring costs and requiring support assistance.

1. **Open Storage Account**

2. **Access Configuration Settings**: In the storage account blade, find the "Settings" section, and click on "Configuration".

3. **Change Redundancy Option**: In the "Configuration" blade, you'll see the current redundancy type. If it's possible to change it (e.g., from LRS to GRS), you'll be able to select a new option from the "Replication" dropdown menu.

4. **Save Changes**: After selecting the new redundancy type, save your changes. Be aware that changing the redundancy type may result in data movement and additional costs.