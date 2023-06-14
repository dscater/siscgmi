<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Plan de Mantenimiento</h1>
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
                                        :plan_mantenimiento="oPlanMantenimiento"
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
            oPlanMantenimiento: {
                id: 0,
                codificacion: "",
                subunidad_id: "",
                gama_id: "",
                pm: "",
                prioridad: "",
                tiempo: "",
                dias: "",
                tipo_mantenimiento: "",
                ultima_fecha_programada: "",
                ultima_fecha_terminada: "",
                programacion: "",
                fecha_final: "",
                variable_control_id: "",
                frecuencia_id: "",
                programacions: [],
            },
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getPlanMantenimiento();
    },
    methods: {
        getPlanMantenimiento() {
            axios("/admin/plan_mantenimientos/" + this.id).then((response) => {
                this.oPlanMantenimiento = response.data.plan_mantenimiento;
            });
        },
    },
};
</script>

<style></style>
