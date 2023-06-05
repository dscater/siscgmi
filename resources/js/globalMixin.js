export default {
    methods: {
        getFormatoFecha(date) {
            console.log(date);
            if (date) {
                return this.$moment(String(date)).format("DD/MM/YYYY");
            }
            return "";
        },
    },
};
