public class CacheRecordByKeyService {
    private Map<String, SObject> cachedRecordByKey = new Map<String, SObject>();

    public Boolean isCached(String key) {
        return this.cachedRecordByKey.containsKey(key);
    }

    public SObject getCachedRecord(String key) {
        return this.cachedRecordByKey.get(key);
    }

    public List<SObject> getCachedRecords(Set<String> keys) {
        return this.getCachedRecordsMap(keys).values();
    }

    public Map<String, SObject> getCachedRecordsMap(Set<String> keys) {
        Map<String, SObject> clonedRecordById = this.cachedRecordByKey.clone();
        clonedRecordById.keySet().retainAll(keys);

        return clonedRecordById;
    }

    public Set<String> getNotCachedKeys(Set<String> keys) {
        Set<String> notCachedKeys = keys.clone();
        notCachedKeys.removeAll(this.cachedRecordByKey.keySet());

        return notCachedKeys;
    }

    public void cacheRecordByFieldPath(SObject record, String fieldPath) {
        this.cachedRecordByKey.put((String) SObjectUtils.getValueByPath(record, fieldPath), record);
    }

    public void cacheRecordsByFieldPath(List<SObject> records, String key) {
        for (SObject record: records) {
            this.cacheRecordByFieldPath(record, key);
        }
    }
}