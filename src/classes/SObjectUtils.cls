public class SObjectUtils {

    public static Object getValueByPath(SObject record, String fieldPath) {
        if (record == null || String.isBlank(fieldPath)) {
            return null;
        }

        return getValueByPath(record, fieldPath.split('.//'));
    }

    public static Object getValueByPath(SObject record, List<String> fieldPath) {
        if (record == null || fieldPath.size() == 0) return null;

        try {
            if (fieldPath.size() > 1) {
                return getValueByPath(record.getSObject(fieldPath.remove(0)), fieldPath);
            }
            return getValueByFieldName(record, fieldPath.remove(0));
        } catch (Exception e) {
            System.debug('\n\n e.getMessage() => ' + e.getMessage() + '\n');
            return null;
        }
    }

    public static Object getValueByFieldName(SObject record, String fieldName) {
        if (record == null || String.isBlank(fieldName)) {
            return null;
        }

        return record.get(fieldName);
    }
}