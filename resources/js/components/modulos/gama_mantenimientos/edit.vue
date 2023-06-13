<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Gama de Mantenimiento</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Modificar registro</h3>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <Formulario
                                        :accion="'edit'"
                                        :gama_mantenimiento="oGamaMantenimiento"
                                    ></Formulario>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
import Formulario from "./Formulario.vue";
export default {
    props: ["id"],
    components: {
        Formulario,
    },
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oGamaMantenimiento: {
                id: 0,
                codigo: "",
                subfamilia_id: "",
                equipo_id: "",
                descripcion: "",
                gama_detalles: [],
            },
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getGamaMantenimiento();
    },
    methods: {
        getGamaMantenimiento() {
            axios("/admin/gama_mantenimientos/" + this.id).then((response) => {
                this.oGamaMantenimiento = response.data.gama_mantenimiento;
            });
        },
    },
};
</script>

<style></style>
