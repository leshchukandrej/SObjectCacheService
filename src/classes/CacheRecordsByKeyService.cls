public with sharing class CacheRecordsByKeyService {
    private Map<String, List<SObject>> cachedRecordsByKey = new Map<String, List<SObject>>();

    public Boolean isCached(String key) {
        return this.cachedRecordsByKey.containsKey(key);
    }

    public List<SObject> getCachedRecords(String key) {
        return this.cachedRecordsByKey.get(key);
    }

    public Map<String, List<SObject>> getCachedRecordsMap(Set<String> keys) {
        Map<String, List<SObject>> clonedRecordsById = this.cachedRecordsByKey.clone();
        clonedRecordsById.keySet().retainAll(keys);

        return clonedRecordsById;
    }

    public Set<String> getNotCachedKeys(Set<String> keys) {
        Set<String> notCachedKeys = keys.clone();
        notCachedKeys.removeAll(this.cachedRecordsByKey.keySet());

        return notCachedKeys;
    }

    public void cacheRecordByFieldPath(SObject record, String fieldPath) {
        String key = (String) SObjectUtils.getValueByPath(record, fieldPath);

        if (!this.cachedRecordsByKey.containsKey(key)) {
            this.cachedRecordsByKey.put(key, new List<SObject>());
        }

        this.cachedRecordsByKey.get(key).add(record);
    }

    public void cacheRecordsByFieldPath(List<SObject> records, String fieldPath) {
        for (SObject record: records) {
            this.cacheRecordByFieldPath(record, fieldPath);
        }
    }
}