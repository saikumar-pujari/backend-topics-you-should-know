##### THIS DB IS MOST FOR SEARCH AND FINDING THE SIMILARITY BETWEEN 2 GIVEN QUERY'S AND RANKING AND FILTERING THEM BASICALLY 
### IN THIS DB WE WILL FOCUS ON PGVECTOR FIRST IF THE DATA GROWS MORE THAN 2 MILLION THEN USE QDRANT

so first i will finish by pgvector and then qdrant only but Milvus i may if i have time or if i have interest in its articture only!

this is the shit order i will follow!
```
Embeddings
      ↓
Cosine Similarity
      ↓
ANN (HNSW, IVF)
      ↓
pgvector(POSTGRESQL) ⭐⭐⭐⭐⭐
      ↓
Qdrant ⭐⭐⭐⭐⭐
      ↓
Milvus (GraphQL+AI features)
```
