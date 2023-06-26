<template>
    <div class="row">
        <div class="col-md-12">
            <div class="row" v-if="muestra_registros">
                <div class="col-md-12">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th v-for="item_dia in dias" width="30px">
                                    {{ dias_txt[item_dia] }}
                                </th>
                            </tr>
                            <tr>
                                <th>CÓDIGO OT</th>
                                <th>EQUIPO</th>
                                <th>DESCRIPCIÓN</th>
                                <th v-for="item_fecha in fechas" width="30px">
                                    {{ $moment(item_fecha).format("DD") }}
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="item in registros">
                                <td>
                                    <router-link
                                        :to="{
                                            name: 'orden_trabajos.orden_trabajo',
                                            params: { id: item.id },
                                        }"
                                        >OT: {{ item.id }}</router-link
                                    >
                                </td>
                                <td>{{ item.gama.equipo.nombre }}</td>
                                <td>{{ item.gama.descripcion }}</td>
                                <td
                                    v-for="item_dia in dias"
                                    :class="{
                                        existe_dia: verificaDia(
                                            item.id,
                                            item_dia
                                        ),
                                    }"
                                >
                                    <span></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-12"></div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props: ["anio_semana"],
    watch: {
        anio_semana(newVal) {
            this.muestra_registros = false;
            if (newVal.length > 1) {
                this.anio = newVal[0];
                this.semana = newVal[1];
                this.getOrdenTrabajosAnioSemana();
            }
        },
    },
    computed: {},
    data() {
        return {
            fecha_actual: "",
            muestra_registros: false,
            anio: this.anio_semana[0],
            semana: this.anio_semana[1],
            dias: [],
            fechas: [],
            dias_txt: [],
            registros_dias: [],
            registros: [],
        };
    },
    mounted() {
        this.getOrdenTrabajosAnioSemana();
    },
    methods: {
        getOrdenTrabajosAnioSemana() {
            axios
                .get("/admin/orden_trabajos/getByAnioSemana", {
                    params: {
                        anio: this.anio,
                        semana: this.semana,
                    },
                })
                .then((response) => {
                    this.dias = response.data.dias;
                    this.fechas = response.data.fechas;
                    this.dias_txt = response.data.dias_txt;
                    this.registros_dias = response.data.registros_dias;
                    this.registros = response.data.registros;
                    this.muestra_registros = true;
                })
                .catch((error) => {
                    this.muestra_registros = false;
                });
        },
        verificaDia(id, dia) {
            console.log(this.registros_dias[dia]);
            let existe = this.registros_dias[dia].filter(
                (elem) => elem.id == id
            )[0];
            return existe;
        },
    },
};
</script>
<style>
.existe_dia {
    padding: 0px;
    text-align: center;
    vertical-align: middle;
}
.existe_dia span {
    display: block;
    height: 25px;
    width: 25px;
    margin: 0px;
    background: red;
}
</style>
